
class DocYard < Doc
  def to_s
    "YARD"
  end

  def handle controller, path, &block
    options = {:disposition=>:inline}
    doc_path = File.join(Rails.root, self.basepath)
    
    requested_full_path = File.expand_path( File.join(Doc.config[:doc_base], path), Rails.root )
    format = controller.request.format.to_sym.to_s

    if File.directory?(requested_full_path)
      file = File.join(requested_full_path, "index.html")
      if File.file? file
        controller.redirect_to File.join('/', Doc.config[:doc_base], path, 'index.html')
        return true
      end
    else
      requested_full_path = [requested_full_path, format].join('.')
    end
    controller.render :file=> requested_full_path, :layout=>false
  end
end
