class TopicFilesController < ApplicationController

  def index
  end

  def show
  end

  def create
    @topic = Topic.friendly.find(params[:topic_id])
    asset = @topic.topic_files.create :asset=>params[:file]
    respond_to do |format|
      format.json { render :json=>asset}
    end
  end
  
  def destroy
    
  end
end
