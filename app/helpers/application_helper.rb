module ApplicationHelper
  def render_md(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(prettify:true, hard_wrap:true),
        :autolink => true, :space_after_headers => true,
        :fenced_code_blocks=>true, :disable_indented_code_blocks=>true, :underline=>true, :footnotes=>true,
        :no_intra_emphasis=>true, :tables=>true)
    markdown.render(text).html_safe
  end
  def asked_by obj
    render :partial=>'/shared/asked_by', :locals=>{:user=>obj.creator, :at => obj.created_at }
  end
  def answered_by obj
    render :partial=>'/shared/answered_by', :locals=>{:user=>obj.creator, :at => obj.created_at }
  end
end


