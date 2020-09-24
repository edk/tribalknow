class QuestionsController < ApplicationController


  def index
    query = Question.order(:id => :desc)

    if params[:tag].present?
      query = query.tagged_with(params[:tag])
    end

    if params[:created_by].present?
      @created_by = User.find_by_id params[:created_by]
      query = query.where(creator_id: params[:created_by])
    end

    if params[:answered_by]
      @answered_by = User.find_by_id params[:answered_by]
      query = query.joins(:answers).where("answers.creator_id" => @answered_by.id)
    end

    # @tag_cloud = Question.tag_counts_on(:tags)

    @questions = query.paginate(:page=>params[:page])
    
    @top = {}
    @top[:qna] = Ahoy::Event.where(name: 'questions#show').limit(12).top(:properties)
    cache_key = [ 'top_qna', @top[:qna].map{ |k,v| v } ]
    @top[:qna] = Rails.cache.fetch(cache_key) do
      @top[:qna].map do |props|
        view_count = ActionController::Base.helpers.content_tag(:span, "#{props[1].to_i}", class:'badge-count')
        {
          count: props[1],
          id: props[0]["id"],
          title: Question.friendly.find(props[0]["id"]).title,
          view_count: view_count
        }
      end
    end
  end

  def show
    @question = Question.friendly.find(params[:id])
  end

  def new
    @question = Question.new
    if params[:topic_id].present?
      @question.topic = Topic.find_by_id(params[:topic_id])
    end
  end

  def edit
    @question = Question.friendly.find(params[:id])
  end

  def notify
    @question = Question.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @question = Question.new(question_params)
    if params[:answer_text].present?
      @answer = Answer.new( text: params[:answer_text])
    end

    respond_to do |format|
      if @question.save
        @question.answers << @answer if @answer
        note = 'Question was successfully created.'
        if params[:notify][:notify] == '1'
          #NotifyHipchat.call(type: action_name.to_sym, object: @question, user: current_user, url: polymorphic_url(@question))
        else
          #if NotifyHipchat.hipchat_configured?
          #  note += view_context.link_to "  Post to Hipchat?", notify_question_path(@question), :remote=>true, :method=>:post
          #end
        end

        format.html { redirect_to @question, notice: note }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.friendly.find(params[:id])

    #NotifyHipchat.call(type: action_name.to_sym, object: @question, user: current_user, url: polymorphic_url(@question)) if params[:notify] && params[:notify][:notify] == '1'

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to root_url, notice: 'Question was successfully updated.' }
        format.json { respond_with_bip(@question) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@question) }
      end
    end
  end

  def destroy
    @question = Question.friendly.find(params[:id])
    if current_user == @question.creator || current_user.admin?
      @question.destroy
      revert_link = view_context.link_to "I didn't mean it! Undo!!! Undo!!! Undo!!!", revert_question_path(@question.versions.last), method: :post
      flash[:notice] = "Succesfully deleted #{@question.title}! #{revert_link}"
      redirect_to action: :index
    else
      flash[:notice] = "You are not the owner of the question and cannot delete it."
      redirect_to :back
    end
  end

  def revert
    question = PaperTrail::Version.find(params[:id]).reify( has_many: true )
    question.save!
    redirect_to question_path(question)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params[:question][:tag_list] = params[:question].delete(:tags)
    params[:question].permit(:title, :text, :topic_id, :tag_list, :notify)
  end

end
