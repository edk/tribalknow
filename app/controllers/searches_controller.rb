class SearchesController < ApplicationController


  def index
    search = Sunspot.search(Question, Topic, Answer) do |query|
      query.keywords params[:q]
      query.paginate(:page => params[:page] || 1, per_page: 3)
    end
    @search = search
  end
end
