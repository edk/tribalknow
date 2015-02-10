require 'render_anywhere'

class StaticSiteGenerator
  include RenderAnywhere

  class RenderingController < RenderAnywhere::RenderingController
    def default_url_options
      { host: 'docset-localhost' }
    end

    def current_user
      User.first
    end
    helper_method :current_user

    def current_tenant
      Tenant.current
    end
    helper_method :current_tenant

    def user_signed_in?
      true
    end
    helper_method :user_signed_in?
  end

  def initialize docset
    @docset = docset
    set_render_anywhere_helpers(QuestionHelper)
  end

  def render_all_to_file
    generate_css_assets
    render_questions
    render_topics
  end

  def render_questions
    set_instance_variable('static_render', true)
    questions = Question.order(:id => :desc)
    page = render(:template => 'questions/index', :locals => { :@questions => questions } )
    @docset.write([:questions, 'index.html'], rewrite_page(page))

    questions.each do |q|
      path = @docset.lookup_path(:questions, "#{q.to_param}.html")
      rel_path  = @docset.lookup_path(:questions_rel, "#{q.to_param}.html")
      page = render('questions/show', :locals => { :@question => q })
      @docset.write(path, rewrite_page(page, path: rel_path) ) do
        insert_db "Question: #{q.title}", 'Entry', rel_path
      end
    end
  end

  def render_topics
    set_instance_variable('static_render', true)
    @topics = Topic.order(:name).where(:parent_topic_id=>nil)
    page = render('topics/index', :locals => { :@topics => @topics })
    @docset.write([:topics, 'index.html'], rewrite_page(page))

    walk_topics(@topics) do |topic|
      path = @docset.lookup_path(:topics, "#{topic.to_param}.html")
      rel_path = @docset.lookup_path(:topics_rel, "#{topic.to_param}.html")
      page = render('topics/show', :locals => { :@topic => topic })
      @docset.write(path, rewrite_page(page, path: rel_path)) do
        insert_db "#{topic.title} - #{topic.description}", 'Guide', rel_path
      end
    end
  end

  def finish
    @docset.finish
  end

  def generate_css_assets
    css_fields = if Rails.env.production?
      ['application.css']
    else
      ['select2-zurb.css', 'mdedit.css', 'autocomplete.css', 'top_nav.css', 'in_place_edit.css',
      'topics.css', 'questions.css', 'drag_n_drop.css', 'alerts_n_errors.css', 'voting.css',
      'diffy.css', 'application.css']
    end
    css_fields.each do |asset|
      # Rails.application.assets.find_asset('application.css').digest
      filename = "#{asset}"
      File.open(@docset.asset_base.join(filename), 'w') do |f|
        f.write Rails.application.assets.find_asset(asset).to_s
      end
    end
  end

  # adjust links and any other transformations needed to be a useful static html page
  def rewrite_page page, options = {}
    doc = Nokogiri::HTML(page)

    doc.css('nav a').each do |link|
      href = case link.attributes['href'].value
      when '/'
        '../topics/index.html'
      when '/topics'
        '../topics/index.html'
      when '/questions'
        '../questions/index.html'
      when '/videos'
        '../videos/index.html'
      else
        link.attributes['href'].value
      end
      link.attributes['href'].value = href
    end

    # rewrite stylsheet links to be relative
    doc.css('head link').each do |link|
      link.attributes['href'].value = link.attributes['href'].value.gsub(/^\/assets/,'../assets')
    end

    doc.css('#content a').each do |link|
      if link.attributes['href'] && link.attributes['href'].to_s !~ /^#/
        ending = (link.attributes['class'].to_s =~ /(anchor_pointer|anchor_link)/) ? '' : '.html'
        link.attributes['href'].value = "#{link.attributes['href'].value.gsub(/^\//,'../')}#{ending}"
      end
    end

    doc.css('img').each do |tag|
      if (src = tag.attributes['src'].to_s).present?
        # download from where-ever it's located... s3? somewhere else?  put it in images/
        uri = URI(src)

        if uri.host
          full_local_path = File.join(@docset.lookup_path(:images), uri.path)
          FileUtils.mkdir_p File.dirname(full_local_path)
          rel_path = File.join('../images', uri.path) # relative path
          tag.attributes['src'].value = rel_path
          begin
            File.open(full_local_path, 'wb') { |f| f.write open(uri).read } unless File.exist?(full_local_path)
          rescue StandardError
            Rails.logger.error "#{$!} #{$!.backtrace}"
          end
        else
          # copy the local file to the new location
        end
      end
    end

    # add every anchor link to the index
    doc.css('a.anchor_link').each do |a|
      name = "##{a.attributes['name']}"
      heading = a.css('h1,h2,h3,h4')
      text = heading.xpath('text()').to_s.strip
      @docset.insert_db text, 'Entry', "#{options[:path]}#{name}" if text.present?
    end

    doc.to_s
  end

  # recurse into topics
  def walk_topics topics, &blk
    if topics.is_a?(Topic)
      yield topics
      walk_topics(topics.sub_topics, &blk) if topics.sub_topics.present?
    else
      topics.each { |topic| walk_topics(topic, &blk) }
    end
  end

end
