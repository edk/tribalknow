class QuestionsController < ApplicationController
  def index
    query = Question.order(:id => :desc)

    if params[:tag].present?
      query = query.tagged_with(params[:tag])
    end
    @questions = query.paginate(:page=>params[:page])
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

  def create
    @question = Question.new(question_params)

    NotifyHipchat.call(type: :create, object: @question, user: current_user) if params[:notify][:notify] == '1'

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_url, notice: 'question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @question = Question.friendly.find(params[:id])

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to root_url, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params[:question][:tag_list] = params[:question].delete(:tags)
    params[:question].permit(:title, :text, :topic_id, :tag_list, :notify)
  end

end
