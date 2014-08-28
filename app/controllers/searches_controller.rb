class SearchesController < ApplicationController


  def index
    @results = get_sphinx_search_results params[:q]
    @results.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
  end

  def autocomplete
    @results = get_sphinx_search_results params[:term]
    @results.map!{|result| { label: result.title, category: result.class.model_name.human, url: url_for(result) }}

    render :json => @results.to_a
  end

  private
  def get_sphinx_search_results(term)
    ThinkingSphinx.search term,
                          :excerpts => { :limit=>255, :around=>20 },
                          :classes => [Question, Answer, Topic, Note],
                          :with=>{ :tenant_id => Tenant.current_id }

  end
end
