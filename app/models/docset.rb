require 'sqlite3'

class Docset
  attr_accessor :base_path, :topic_base, :ques_base, :asset_base

  def initialize options = {}
    raise "Missing required key in Docset initialize(#{options.inspect})" if options.keys.any? { |k| !options.has_key?(k) }

    @name = options[:name]
    @base_path  = options[:base_path]

    @topic_base = @base_path.join('Contents/Resources/Documents/topics')
    @ques_base  = @base_path.join('Contents/Resources/Documents/questions')
    @asset_base = @base_path.join('Contents/Resources/Documents/assets')
    FileUtils.mkdir_p [@base_path, @asset_base, @topic_base, @ques_base]

    gen_plist @base_path
    init_db @base_path
  end

  def finish
    if @db
      close_db
      @db = nil
    end
  end

  def gen_plist base_path
    File.open("#{@base_path}/Contents/Info.plist",'w') { |f| f.write(plist) }
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

  def init_db base_path
    db_file = "#{@base_path}/Contents/Resources/docSet.dsidx"
    File.unlink(db_file) if File.exist?(db_file)
    @db = SQLite3::Database.new "#{@base_path}/Contents/Resources/docSet.dsidx"
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
end
