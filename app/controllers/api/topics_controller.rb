class Api::TopicsController < Api::BaseController

  def show
    topic = Topic.friendly.find(params[:id])

    respond_to do |format|
      format.json do
        render :json => {
          title: topic.name,
          description: topic.description,
          text: topic.content,
          creator: topic.creator.try(:name),
          resource_url: resource_url(topic)
        }
      end
    end
  end

end
