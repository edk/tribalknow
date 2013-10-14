module ApplicationHelper
  def render_md(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(prettify:true, hard_wrap:true),
        :autolink => true, :space_after_headers => true, :fenced_code_blocks=>true, :underline=>false, :footnotes=>true)
    markdown.render(text).html_safe
  end

end
