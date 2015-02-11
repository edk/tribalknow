require 'sqlite3'

class Docset
  attr_accessor :base_path, :topic_base, :ques_base, :asset_base, :image_base

  def initialize options = {}
    raise "Missing required key in Docset initialize(#{options.inspect})" if options.keys.any? { |k| !options.has_key?(k) }

    @name = options[:name]
    @base_path  = options[:base_path]

    @topic_base = @base_path.join('Contents/Resources/Documents/topics')
    @ques_base  = @base_path.join('Contents/Resources/Documents/questions')
    @asset_base = @base_path.join('Contents/Resources/Documents/assets')
    @image_base = @base_path.join('Contents/Resources/Documents/images')

    @paths = { base: @base_path, topics: @topic_base, questions: @ques_base, assets: @asset_base, images: @image_base}
    FileUtils.mkdir_p @paths.values.map(&:to_s)

    @paths = @paths.inject({}) { |m, (k,v)|
      m[k] = v
      m["#{k}_rel".to_sym] = v.to_s.gsub %r|#{@base_path}/Contents/Resources/Documents/|, ''
      m
    }

    gen_plist @base_path
    init_db @base_path
  end

  def lookup_path k, filename = nil
    raise "key not found" unless @paths.has_key?(k)
    path = Pathname.new(@paths[k])
    path = path.join(filename.to_s) if filename
    path
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

  def write filename, page, &block
    filepath = if filename.is_a?(Array)
      # a 2 element array
      #  1) a symbol that maps to the type of prefix
      #  2) the filename to append to it
      lookup_path(filename.first, filename.last)
    else
      filename
    end

    instance_eval &block if block_given?

    File.open(filepath, 'w') { |f| f.write page }
  end

  def plist
    plist = %Q|
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleIdentifier</key>
      <string>#{@name}</string>
      <key>CFBundleName</key>
      <string>#{@name}</string>
      <key>DocSetPlatformFamily</key>
      <string>#{@name}</string>
      <key>isDashDocset</key>
      <true/>
      <key>dashIndexFilePath</key>
      <string>topics/index.html</string>
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
