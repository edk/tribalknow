require 'will_paginate/view_helpers/action_view'

module PaginationHelper
  class FoundationLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected
    def html_container(html)
     tag(:ul, html, container_attributes) 
    end

    def page_number(page)
     tag :li, link(page, page, :rel => rel_value(page)), :class => ('current' if page == current_page)
    end

    def gap
     tag :li, link(super, '#'), :class => 'unavailable'
    end

    def previous_or_next_page(page, text, classname)
     tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('unavailable' unless page)].join(' ')
    end
  end
  def will_paginate(pages)
    super(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => FoundationLinkRenderer, :previous_label => '&laquo;'.html_safe, :next_label => '&raquo;'.html_safe)
  end
end
