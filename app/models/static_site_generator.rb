
class StaticSiteGenerator
  include RenderAnywhere

  class RenderingController < RenderAnywhere::RenderingController
    def default_url_options
      { host: 'localhost' }
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
    @questions = Question.order(:id => :desc)
    str = render(:template => 'questions/index', :locals => { :@questions => @questions } )
    File.open(@docset.ques_base.join('index.html'),'w') { |f| f.write rewrite_page(str) }

    @questions.each do |q|
      path = @docset.ques_base.join("#{q.to_param}.html")
      @docset.insert_db q.title, 'Entry', path.to_s.gsub(%r|#{@docset.base_path}/Contents/Resources/Documents/|, '')
      str = render('questions/show', :locals => { :@question => q })
      page = rewrite_page(str, path: path.to_s.gsub(%r|#{@docset.base_path}/Contents/Resources/Documents/|, ''))
      File.open(path, 'w') { |f| f.write page }
    end
  end

  def render_topics
    set_instance_variable('static_render', true)
    @topics = Topic.order(:name).where(:parent_topic_id=>nil)
    str = render('topics/index', :locals => { :@topics => @topics })
    File.open(@docset.topic_base.join('index.html'),'w') { |f| f.write rewrite_page(str) }

    walk_topics(@topics) do |topic|
      path = @docset.topic_base.join("#{topic.to_param}.html")
      @docset.insert_db "#{topic.title} - #{topic.description}", 'Guide', path.to_s.gsub(%r|#{@docset.base_path}/Contents/Resources/Documents/|, '')
      str = render('topics/show', :locals => { :@topic => topic })
      page = rewrite_page(str, path: path.to_s.gsub(%r|#{@docset.base_path}/Contents/Resources/Documents/|, ''))
      File.open(path, 'w') { |f| f.write page }
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

    doc.css('head link').each do |link|
      link.attributes['href'].value = link.attributes['href'].value.gsub(/^\/assets/,'../assets')
    end

    doc.css('#content a').each do |link|
      if link.attributes['href'] && link.attributes['href'].to_s !~ /^#/
        ending = (link.attributes['class'].to_s =~ /(anchor_pointer|anchor_link)/) ? '' : '.html'
        puts "\nlink.attributes['class'] = #{link.attributes['class'].inspect} -- ending = #{ending}"
        link.attributes['href'].value = "#{link.attributes['href'].value.gsub(/^\//,'../')}#{ending}"
      end
    end

    if @db
      doc.css('a.anchor_link').each do |a|
        name = "##{a.attributes['name']}"
        heading = a.css('h1,h2,h3,h4')
        text = heading.xpath('text()').to_s.strip
        insert_db text, 'Entry', "#{options[:path]}#{name}" if text.present?
      end
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
