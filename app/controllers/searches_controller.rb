class SearchesController < ApplicationController
  include SearchHelper
  skip_after_action :track_action

  def index
    PgSearch.multisearch_options = {
      using: [:tsearch, :trigram],
      ignoring: :accents
    }
    PgSearch.unaccent_function = "unaccent"

    @results = PgSearch.multisearch(params[:q])

    Searchjoy::Search.create(
      query: params[:q],
      results_count: @results.count,
      user_id: current_user.id
    ) unless request.xhr?

    @results = @results.paginate(page: (params[:page]||1), per_page: 25)

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
