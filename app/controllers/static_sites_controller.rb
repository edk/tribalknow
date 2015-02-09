
require 'sqlite3'

class StaticSitesController < ApplicationController

  def base_path
    base_path  = Rails.root.join('docs/tmp/q.docset')
  end

  def show
    topic_base = base_path.join('Contents/Resources/Documents/topics')
    ques_base  = base_path.join('Contents/Resources/Documents/questions')
    asset_base = base_path.join('Contents/Resources/Documents/assets')
    FileUtils.mkdir_p [base_path, asset_base, topic_base, ques_base]

    gen_plist base_path
    init_db base_path

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
      path = ques_base.join("#{q.to_param}.html")
      insert_db q.title, 'Entry', path.to_s.gsub(%r|#{base_path}/Contents/Resources/Documents/|, '')
      page = rewrite_page(render_to_string('questions/show'), path: path.to_s.gsub(%r|#{base_path}/Contents/Resources/Documents/|, ''))
      File.open(path, 'w') { |f| f.write page }
    end

    @topics = Topic.order(:name).where(:parent_topic_id=>nil)
    File.open(topic_base.join('index.html'),'w') { |f| f.write rewrite_page(render_to_string('topics/index')) }

    walk_topics(@topics) do |topic|
      @topic = topic
      path = topic_base.join("#{topic.to_param}.html")
      insert_db topic.title, 'Guide', path.to_s.gsub(%r|#{base_path}/Contents/Resources/Documents/|, '')
      page = rewrite_page(render_to_string('topics/show'), path: path.to_s.gsub(%r|#{base_path}/Contents/Resources/Documents/|, ''))
      File.open(path, 'w') { |f| f.write page }
    end

    close_db

    render text: 'ok'
  end

  protected

  def init_db base_path
    db_file = "#{base_path}/Contents/Resources/docSet.dsidx"
    File.unlink(db_file) if File.exist?(db_file)
    @db = SQLite3::Database.new "#{base_path}/Contents/Resources/docSet.dsidx"
    @db.execute <<-SQL
      CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);
      CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);
    SQL
  end

  def insert_db name, type, path
    @db.execute("INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (?, ?, ?);", [name, type, path.to_s])
  end

  def close_db
    @db.close
  end

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
      link.attributes['href'].value = "#{link.attributes['href'].value.gsub(/^\//,'../')}.html" if link.attributes['href']
    end

    if @db
      doc.css('h1,h2,h3,h4').each do |heading|
        text = heading.xpath('text()').to_s.strip
        insert_db text, 'Entry', options[:path] if text.present?
      end
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

  def gen_plist base_path
    File.open("#{base_path}/Contents/Info.plist",'w') { |f| f.write(plist) }
  end

  def plist
    # <key>dashIndexFilePath</key><string>guides.rubyonrails.org/index.html</string><key>CFBundleName</key>
    plist = %Q|
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleIdentifier</key>
      <string>Q</string>
      <key>CFBundleName</key>
      <string>Coupa Q</string>
      <key>DocSetPlatformFamily</key>
      <string>Q</string>
      <key>isDashDocset</key>
      <true/>
    </dict>
    </plist>
    |.strip
  end

end
