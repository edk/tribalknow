module ApplicationHelper
  def render_md(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(prettify:true, hard_wrap:true),
        :autolink => true, :space_after_headers => true,
        :fenced_code_blocks=>true, :disable_indented_code_blocks=>true, :underline=>true, :footnotes=>true,
        :no_intra_emphasis=>true, :tables=>true)
    markdown.render(text).html_safe
  end

end
