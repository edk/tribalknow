module ApiHelper

  def get_sphinx_search_results(term, filter='question,answer,topic')
    filter_by = filter.split(',').map{ |f| f.capitalize.constantize }
    ThinkingSphinx.search Riddle::Query.escape(term),
                        :excerpts => { :limit=>255, :around=>50 },
                        :classes => filter_by,
                        :with=>{ :tenant_id => Tenant.current_id },
                        :per_page => per_page, :page=>params[:page]
  end

  def api_resource_url(resource)
    res = resource.instance_of?(Answer) ? resource.question : resource
    return "" if res.nil?
    url_for controller: "api/#{res.class.name.tableize}",
            action: :show,
            format: :json,
            id: res.try(:slug)
  end

  def resource_url(resource)
    resource.instance_of?(Answer) ? url_for(resource.question) : url_for(resource)
  end

  def per_page
    40
  end

end
