class SearchesController < ApplicationController


  def index
    @results = ThinkingSphinx.search params[:q],
                                    :classes => [Question, Answer, Topic],
                                    :with=>{ :tenant_id => Tenant.current_id }
  end
end
