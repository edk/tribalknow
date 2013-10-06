class SearchesController < ApplicationController
  def index
    search = Sunspot.search Question, Topic do |query|
      query.keywords params[:q]
    end
    @search = search
  end
end
