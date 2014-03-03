module ApplicationHelper
  def render_md(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(prettify:true, hard_wrap:true),
        :autolink => true, :space_after_headers => true,
        :fenced_code_blocks=>true, :disable_indented_code_blocks=>true, :underline=>true, :footnotes=>true,
        :no_intra_emphasis=>true, :tables=>true)
    markdown.render(text).html_safe
  end

  def render_gravatar user, options = {}
    opt_string = "?s=#{options[:size]}" if options[:size]
    image_tag("#{request.protocol}www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip.downcase)}#{opt_string}")
  end

  def asked_by obj
    render :partial=>'/shared/asked_by', :locals=>{:user=>obj.creator, :at => obj.created_at }
  end

  def answered_by obj
    render :partial=>'/shared/answered_by', :locals=>{:user=>obj.creator, :at => obj.created_at }
  end

  def render_tags
    
  end

  # foundation icon generate
  def f_icon name, options={}
    css_class = ["fi-#{name}", options[:class]].join(" ").strip
    if options[:color]
      options[:style] = [ "color:#{options[:color]}", options[:style] ].join(";").strip
      options.delete(:color)
    end
    if options[:size]
      options[:style] = [ "font-size:#{options[:size]}", options[:style] ].join(";").strip
      options.delete(:size)
    end
    content_tag(:i, nil, options.merge(:class=>css_class))
  end
end


