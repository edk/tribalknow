class StaticSitesController < ApplicationController

  def show
    # index
    base_path = Rails.root.join('docs/tmp')
    FileUtils.mkdir_p base_path

    topic_base = base_path.join('topics')
    ques_base  = base_path.join('questions')
    # FileUtils.mkdir_p topic_base.join('stylesheets')
    asset_base = base_path.join('assets')
    FileUtils.mkdir_p asset_base
    FileUtils.mkdir_p topic_base
    FileUtils.mkdir_p ques_base

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
      File.open(asset_base.join(filename), 'w') do |f|
        f.write Rails.application.assets.find_asset(asset).to_s
      end
    end

    @static_render = true

    @questions = Question.order(:id => :desc)
    File.open(ques_base.join('index.html'),'w') { |f| f.write rewrite_page(render_to_string('questions/index')) }
    @questions.each do |q|
      @question = q
      File.open(ques_base.join("#{q.to_param}.html"),'w') { |f| f.write rewrite_page(render_to_string('questions/show')) }
    end

    @topics = Topic.order(:name).where(:parent_topic_id=>nil)
    File.open(topic_base.join('index.html'),'w') { |f| f.write rewrite_page(render_to_string('topics/index')) }

    walk_topics(@topics) do |topic|
      @topic = topic
      File.open(topic_base.join("#{topic.to_param}.html"),'w') { |f| f.write rewrite_page(render_to_string('topics/show')) }
    end


    render text: 'ok'
  end

  protected

  def rewrite_page page, options = {}
    doc = Nokogiri::HTML(page)

    doc.css('nav a').each do |link|
      puts "link.attributes['href'].value = #{link.attributes['href'].value}"
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
      link.attributes['href'].value = "#{link.attributes['href'].value.gsub(/^\//,'../')}.html" if link.attributes['href']
    end

    doc.to_s
  end

  def walk_topics topics, &blk
    if topics.is_a?(Topic)
      yield topics
      walk_topics(topics.sub_topics, &blk) if topics.sub_topics.present?
    else
      topics.each { |topic| walk_topics(topic, &blk) }
    end
  end

end
