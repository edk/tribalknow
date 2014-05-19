class VotesController < ApplicationController
  include ActionView::RecordIdentifier
  
  def create
    allowed_types = %w[ answer question ]
    type = allowed_types[allowed_types.index(params[:type])]    
    object = type.classify.constantize.find(params[:id])
    
    if params[:vote] == 'upvote'
      current_user.likes object
      @add_elem = "##{dom_id(object,'up')}"
      @del_elem = "##{dom_id(object,'down')}"
    elsif params[:vote] == 'downvote'
      current_user.dislikes object
      @add_elem = "##{dom_id(object,'down')}"
      @del_elem = "##{dom_id(object,'up')}"
    end
    
    respond_to do |format|
      format.js
    end
    
  end
end
