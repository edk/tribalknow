
module ApplicationHelper
  def render_md(text)
    GitHub::Markdown.render_gfm(sanitize(text)).html_safe
  end

  def render_gravatar user, options = {}
    if user
      opt_string = "?s=#{options[:size]}" if options[:size]
      image_tag("#{request.protocol}www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip.downcase)}#{opt_string}")
    else
      size = "40x40"
      size = "#{options[:size]}x#{options[:size]}" if options[:size]
      image_tag("#{request.protocol}placehold.it/#{size}")
    end
  end

  def render_tag_links tags, options={}
    tags.map do |tag|
      link_to tag, questions_path(:tag=>tag.name), :class=>'taglink'
    end.join(' ').html_safe
  end

  def smart_display(obj, options={})
    case obj
    when Time, DateTime
      if (obj+1.day).future?  # very recent
        l(obj, :format=>:short)
      elsif (DateTime.now - 8.months) < obj  # medium.  show month, day
        l(obj, :format=>:monthday)
      else # really old, show year
        l(obj, :format=>:onlydate)
      end
    else
      obj
    end
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

  def in_place_edit_panel note, path
    title = content_tag(:h3, best_in_place(note, :title,{ :as=>:input, :raw=>true }))

    edit_content_id = dom_id(note, :content)
    content = best_in_place(note, :content, {:as=>:textarea, :raw=>true, :activator=>"##{edit_content_id}", :display_with=>lambda{ |content| content.to_s.html_safe}})
    edit_icon = f_icon('pencil', :id=>edit_content_id, :class=>'edit_icon')

    content_tag(:div, "#{title} #{content} &nbsp;#{edit_icon}".html_safe, :class=>'panel')
  end

  # display a series of panels per controller/action
  def local_notes options = {}
    # if user is creator or admin, add link to admin
    allow_admin = options[:disable_admin] && current_user && !current_user.admin?
    path = "#{controller_name}/#{action_name}"

    notes = Note.where(:path=>path)
    str = notes.map do |note|
      in_place_edit_panel(note, path)
    end.join.html_safe

    str << content_tag(:div, link_to("Add New Note", notes_path(:path=>path), :method=>:post, :remote=>true), :class=>'panel', :id=>"add_#{path.gsub(/\//,'_')}")# if allow_admin

    str
  end

  # like local_notes but private?
  def private_notes
    
  end
end


