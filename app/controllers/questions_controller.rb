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

  def notify
    @question = Question.find(params[:id])

    NotifyHipchat.call(type: :create, object: @question, user: current_user, url: polymorphic_url(@question), verb_override: params[:ping].present?)

    respond_to do |format|
      format.js
    end
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        note = 'Question was successfully created.'
        if params[:notify][:notify] == '1'
          NotifyHipchat.call(type: action_name.to_sym, object: @question, user: current_user, url: polymorphic_url(@question))
        else
          if NotifyHipchat.hipchat_configured?
            note += view_context.link_to "  Post to Hipchat?", notify_question_path(@question), :remote=>true, :method=>:post
          end
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

    NotifyHipchat.call(type: action_name.to_sym, object: @question, user: current_user, url: polymorphic_url(@question)) if params[:notify] && params[:notify][:notify] == '1'

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
