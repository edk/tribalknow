class TopicsController < ApplicationController

  def index
    # using the .roots scope orders by lft which is not what we want on the index.
    @topics = Topic.order(:name).where(:parent_topic_id=>nil).paginate(:page=>params[:page], :per_page=> 3*20 )
    @topics_cache_key = [ @topics.pluck(:id), @topics.maximum(:updated_at) ]
  end

  def show
    @topic = Topic.friendly.find(params[:id])
  end

  def show_history
    topic = Topic.friendly.find(params[:id])
    @ver = topic.versions.find(params[:ver])
  end

  def set_icon
    topic = Topic.friendly.find(params[:id])
    topic.icon = params[:file]
    respond_to do |format|
      format.json {
        if topic.save
          render :status=>:ok, :json => { :url => topic.icon.url(:thumb) }
        else
          render :status=>:unprocessable_entity, :json => {:error=>topic.errors}
        end
      }
    end
  end

  def new
    @topic = Topic.new
    @topic.parent_topic_id = Topic.find_by_id(params[:parent_topic_id]).id if params[:parent_topic_id].present?
  end

  def edit
    @topic = Topic.friendly.find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    topic_redir_to = if @topic.parent_topic
      topic_url(@topic.parent_topic.id)
    else
      topics_url
    end

    respond_to do |format|
      if @topic.save
        NotifyHipchat.call(type: action_name.to_sym, object: @topic, user: current_user, url: polymorphic_url(@topic)) if params[:notify][:notify] == '1'
        format.html { redirect_to topic_redir_to, notice: 'Topic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @topic }
      else
        format.html { render action: 'new' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @topic = Topic.friendly.find(params[:id])

    NotifyHipchat.call(type: action_name.to_sym, object: @topic, user: current_user, url: polymorphic_url(@topic)) if params[:notify] && params[:notify][:notify] == '1'

    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_path(@topic), notice: 'Topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic = Topic.friendly.find(params[:id])

    NotifyHipchat.call(type: action_name.to_sym, object: @topic, user: current_user, url: polymorphic_url(@topic)) if params[:notify] && params[:notify][:notify] == '1'

    if current_user.admin? || current_user == @topic.creator
      @topic.destroy
      flash[:notice] = "Deleted topic, '#{@topic.name}'"
    else
      flash[:alert] = "You are not authorized to perform this action."
    end
    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params[:topic][:tag_list] = params[:topic].delete(:tags)
    params[:topic].permit(:name, :description, :content, :parent_topic_id, :tag_list )
  end
end
