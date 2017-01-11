class Api::SearchController < Api::BaseController

  def index
    results = get_sphinx_search_results params[:q], params[:filter]
    results.map! do |result|
      label = if result.try(:name) && result.try(:description)
        "#{result.name}: #{result.description}"
      else
        result.title
      end
      {
        label: label,
        category: result.class.model_name.human,
        url: api_resource_url(result)
      }
    end

    respond_to do |format|
      format.json do
        render :json => results.to_a
      end
    end
  end

end
