
module ApplicationHelper

  def render_custom_text position
    location = "#{controller_name}/#{action_name}"

    if custom = CustomizedPage.location(location)
      header, text = custom.at(position)
    end

    if block_given?
      yield header.to_s.html_safe, text.to_s.html_safe
    else
      text.to_s.html_safe
    end if text.present?

  end

  def set_title page_title, options={}
    location = "#{controller_name}/#{action_name}"
    if custom = CustomizedPage.location(location)
      custom_title = custom.title
    end

    content_for :title, (custom_title || page_title.presence || "TribalKnowNow")
  end

  def render_md(text, options = {})
    html = GitHub::Markdown.render_gfm(text)
    html = reverse_entity_encoding_inside_code_blocks(html)
    html, toc = add_anchor_links_to_headers(html)
    if options[:with_toc]
      [html, toc]
    else
      html
    end
  end

  def reverse_entity_encoding_inside_code_blocks html
    doc = Nokogiri::HTML::DocumentFragment.parse html
    code_blocks = doc.css "code"
    code_blocks.each { |node| node.content = CGI.unescapeHTML(node.content) }
    doc.to_s.html_safe
  end

  def create_and_add_anchor_node h, doc
    anchor = Nokogiri::XML::Node.new 'a', doc

    anchor_link = Nokogiri::XML::Node.new 'i', doc
    anchor_link['class'] = "fi-link header_anchor_link"
    anchor_link.parent = anchor

    # add it next to the header tag, and then put the header inside the anchor
    h.add_next_sibling(anchor)
    h.parent = anchor

    # add some local #href flavor
    anchor['class'] = 'anchor_link'
    name_slug       = h.content.to_s.parameterize
    anchor['href']  = "##{name_slug}"
    anchor['name']  = "#{name_slug}"

    name_slug
  end

  def add_anchor_links_to_headers html
    doc = Nokogiri::HTML::DocumentFragment.parse html

    toc = [[]]
    cur_level = [0]
    levels = {}
    cur_pos = toc.first
    first_level = nil

    headers = doc.css "h1,h2,h3,h4"
    headers.each { |h|
      h.name =~ /([0-9]+)/ # h.name => h2, h3, h4 etc
      header_level = $1.to_i

      first_level = header_level if first_level.nil?
      header_level = header_level - first_level
      header_level = 0 if header_level < 0


      # create a new anchor node
      name_slug = create_and_add_anchor_node h, doc

      if header_level > (cur_level.last || 0)
        levels[header_level] = cur_pos
        cur_level << header_level
        cur_pos << []
        cur_pos = cur_pos.last
      elsif header_level < cur_level.last
        cur_level = cur_level.reverse.drop_while { |el| el > header_level }.reverse if cur_level.size > 0
        cur_level = [0] if cur_level.nil? || cur_level.size == 0
        cur_pos = levels[header_level]
        cur_pos = toc.last if cur_pos.nil?
        cur_pos = [ cur_pos ] if cur_pos.is_a? Hash
      else
        # keep appending at the current level
      end

      cur_pos << {level: header_level, content: h.content, slug: "##{name_slug}"}
    }

    [doc.to_s.html_safe, toc]
  end

  def render_toc_tree toc, options = {}
    rv = toc.map do |elem|
      if elem.is_a? Array
        next if elem.empty?
        render_toc_tree elem, skip_first_ul: false
      elsif elem.is_a? Hash
        content_tag(:li, link_to("#{elem[:content]}", elem[:slug], class: 'anchor_pointer') )
        #content_tag(:li, link_to("(#{elem[:level]}) #{elem[:content]}", elem[:slug], class: 'anchor_pointer') )
      end
    end
    content = safe_join(rv)

    if options[:skip_first_ul]
      content
    else
      content_tag(:ul, content, class: "panel_list toc_tree")
    end
  end

  def render_avatar user, options = {}
    return unless user

    if user.avatar?
      opts = if options[:size]
        size = if options[:size] == :small
          "28x28"
        elsif options[:size].to_s =~ /x/
          options[:size]
        else
          "#{options[:size]}x#{options[:size]}"
        end
        { :size => size }
      else
        {}
      end
      image_tag user.avatar.url(:thumb), opts.merge(alt: user.name, title:user.name, class:'rounded-circle')
    else
      render_gravatar user, options
    end
  end

  def gravitar_url user, opt_string = ""
    "#{request.protocol||'https://'}www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip.downcase)}#{opt_string}"
  end

  def render_gravatar user, options = {}
    size = if options[:size] == :small
        "28x28"
      elsif options[:size]
        options[:size]
      else
        nil
    end

    if user
      opt_string = "?s=#{size}" if size
      image_tag(gravitar_url(user, opt_string), :alt=>user.name, :title=>user.name)
    else
      size = "40x40"
      size = "#{options[:size]}x#{options[:size]}" if options[:size]
      image_tag("#{request.protocol||'https://'}placehold.it/#{size}")
    end
  end

  def render_tag_links tags, options={}
    tags.map do |tag|
      link_to tag, questions_path(:tag=>tag.name), :class=>'badge badge-info'
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
  def f_icon type, name, options={}
    css_class = ["#{type} fa-#{name}", options[:class]].join(" ").strip
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

  def best_in_place_with_edit_icon obj, method, opts = {}
    # this is a wip.  started using it but wasn't happy with it, so i need to circle back later
    edit_content_id = dom_id(obj, method)

    addl_options = { :activator => "##{edit_content_id}" }

    if @static_render
      rv = obj.send method
      rv = opts[:display_with].call(rv) if opts[:display_with]
    else
      rv = best_in_place obj, method, opts.merge(addl_options)
      rv << f_icon('pencil', :id=>edit_content_id, :class=>'edit_icon_right')
    end

    rv.html_safe
  end

  def in_place_edit_panel note, path
    content_tag(:div, { class: 'card card-lists' }) do
      content_tag(:div, { class: 'card-body p-0' }) do
        content_tag(:div, { class: 'card-header' }) do
          title = content_tag(:h5, best_in_place(note, 'title' , {:as=>'input', :raw=>true }), {class: 'card-title'} )

          edit_content_id = dom_id(note, :content)
          content = best_in_place(note, :content, {:as=>'textarea', :raw=>true, :activator=>"##{edit_content_id}", :display_with=>lambda{ |content| content.to_s.html_safe}})
          edit_icon = f_icon('pencil', :id=>edit_content_id, :class=>'edit_icon')
          note_body = content_tag(:div, {}) do
            content_tag(:div, content, {}) +
            content_tag(:span, "&nbsp;#{edit_icon}".html_safe)
          end
          title + note_body
        end
      end
    end
  end

  # display a series of panels per controller/action
  def local_notes options = {}
    # if user is creator or admin, add link to admin
    allow_admin = !options[:disable_admin] && current_user && !current_user.admin?
    path = "#{controller_name}/#{action_name}"

    notes = Note.where(:path=>path)

    if notes.empty? && options[:fixed]
      notes = [Note.create!(:path=>path, :title => options[:default_title])]
    end

    str = notes.map do |note|
      in_place_edit_panel(note, path)
    end.join.html_safe

    klasses = "card"
    str << content_tag(:div, link_to("Add New Note", notes_path(:path=>path), :method=>:post, :remote=>true), :class=>klasses, :id=>"add_#{path.gsub(/\//,'_')}") if allow_admin

    str
  end

  # like local_notes but private?
  def private_notes
  end

end
