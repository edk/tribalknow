class SearchesController < ApplicationController


  def index
    @results = ThinkingSphinx.search params[:q],
                                    :excerpts => { :limit=>255, :around=>20 },
                                    :classes => [Question, Answer, Topic],
                                    :with=>{ :tenant_id => Tenant.current_id }
    @results.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
  end
end
