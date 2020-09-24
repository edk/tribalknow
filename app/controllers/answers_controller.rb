class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @question = Question.friendly.find(params[:question_id])
    redirect_to question_path(@question)
  end

  def new
    @answer = Answer.new
  end

  def show
    @answer = Answer.find(params[:id])
    redirect_to question_url(@answer.question, :anchor=>"answer_#{@answer.id}")
  end

  def notify
    @answer = Answer.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @question = Question.friendly.find(params[:question_id])
    @answer = @question.answers.build(answer_params)

    respond_to do |format|
      if @answer.save
        note = 'Answer was successfully created.'

        if params[:notify][:notify] == '1'
          #NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user, url: polymorphic_url([@answer.question, @answer]))
        else
          #if NotifyHipchat.hipchat_configured?
          #  note += view_context.link_to "  Post to Hipchat?", notify_question_answer_path(@question, @answer), :remote=>true, :method=>:post
          #end
        end

        format.html { redirect_to @question, notice: note }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { redirect_to @question, notice: @answer.errors.full_messages.join("<br/>".html_safe) }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user, url: polymorphic_url([@answer.question, @answer])) if params[:notify] && params[:notify][:notify] == '1'
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { respond_with_bip(@answer) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@answer) }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    if current_user == @answer.creator || current_user.admin?
      @answer.destroy!

      revert_link = view_context.link_to "I didn't mean it! Undo!!! Undo!!! Undo!!!", revert_question_answer_path(@answer.question, @answer.versions.last), method: :post
      flash[:notice] = "Succesfully deleted: '#{@answer.title.truncate(50, :separator => ' ')}'! #{revert_link}"
      redirect_to question_path(@answer.question)
    else
      flash[:notice] = "You are not the owner of the question and cannot delete it."
      redirect_to :back
    end
  end

  def revert
    answer = PaperTrail::Version.find(params[:id]).reify
    answer.save!
    redirect_to question_path(answer.question)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params[:answer].permit(:text)
    end
end
