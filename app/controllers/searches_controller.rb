class SearchesController < ApplicationController
  include SearchHelper
  skip_after_action :track_action

  def index

    Searchjoy::Search.create(
      query: params[:q],
      results_count: @results.size,
      user_id: current_user.id
    ) unless request.xhr?

    respond_to do |format|
      format.html #do nothing, defaults to default template
      format.json do
        @results.map! { |result| { label: result.title, category: result.class.model_name.human, url: resource_url(result)} }
        render :json => @results.to_a
      end
    end
  end

  def autocomplete
    index
  end

  private

  def per_page
    25
  end

  def resource_url(resource)
    resource.instance_of?(Answer) ? url_for(resource.question) : url_for(resource)
  end

end
