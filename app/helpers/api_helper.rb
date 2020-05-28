module ApiHelper

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
