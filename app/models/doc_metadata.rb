
class DocMetadata < Doc
  has_many :docs, -> { order 'name' }, :foreign_key=>'doc_group_id'

  def self.route(path, controller)
    # find a particular doc by matching the prefix.  DANGER: don't allow arbitrary access to filesystem!
    if "/#{config[:doc_base]}/#{path}" =~ /#{config[:yard_path]}/
      found_doc = Doc.where('basepath like ?', config[:yard_path])
    else
      found_doc = Doc.where('basepath like ?', "/#{config[:doc_base]}/#{path}%")
    end

    # found can be zero, one or more
    # Need to handle path - prefix to show the right file
    if !found_doc.empty?
      if found_doc.size > 1
        raise "hmm. there may be a problem here"
      end
      found_doc = found_doc[0]
      return found_doc.handle(controller, path)
    end
  end

  def sync
    docs.destroy_all
    # search for different doctypes in the current path.
    Dir.glob(File.join(path, "*")).each { |f|
      filename = f.split('/').last
      path  = f
      bpath = path.to_s.gsub(/^#{Rails.root.to_s}/,'')
      opts = {:name=>name, :path=>path, :basepath=>bpath}

      case filename
      when /^yard$/
        docs << DocYard.new(opts)
      when /\.docset.zip$/
        docs << DocDocsetZip.new(opts)
      # when /^dot$/
        # docs << DocDot.new(:name=>name, :path=>f)
      else
        puts "filename = #{filename}"
      end

    }
  end

  def path
    Rails.root.join(attributes['path'])
  end
end
