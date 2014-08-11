
class DocDocsetZip < Doc
  def to_s
    "Docset.zip"
  end

  def handle controller, path, &block
    options = {:disposition=>:attachment}

    doc_path = File.join(Rails.root, self.basepath)
    requested_full_path = File.expand_path( File.join(Doc.config[:doc_base], path), Rails.root )
    format = controller.request.format.to_sym.to_s

    requested_full_path = [requested_full_path, format].join('.')
    controller.send_file requested_full_path, options
  end
end
