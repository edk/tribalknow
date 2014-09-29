class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  def show
    @answer = Answer.find(params[:id])
    redirect_to question_url(@answer.question, :anchor=>"answer_#{@answer.id}")
  end

  def notify
    @answer = Answer.find(params[:id])
    NotifyHipchat.call(type: :create, object: @answer, user: current_user, url: polymorphic_url([@answer.question, @answer]))

    respond_to do |format|
      format.js
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)

    respond_to do |format|
      if @answer.save
        note = 'Answer was successfully created.'

        if params[:notify][:notify] == '1'
          NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user, url: polymorphic_url([@answer.question, @answer]))
        else
          if NotifyHipchat.hipchat_configured?
            note += view_context.link_to "  Post to Hipchat?", notify_question_answer_path(@question, @answer), :remote=>true, :method=>:post
          end
        end

        format.html { redirect_to @question, notice: note }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
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
    @answer.destroy
    
    NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user, url: polymorphic_url([@answer.question, @answer])) if params[:notify][:notify] == '1'

    respond_to do |format|
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
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
