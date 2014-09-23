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

  # POST /answers
  # POST /answers.json
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)

    NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user) if params[:notify][:notify] == '1'

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
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
        NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user) if params[:notify] && params[:notify][:notify] == '1'
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
    
    NotifyHipchat.call(type: action_name.to_sym, object: @answer, user: current_user) if params[:notify][:notify] == '1'

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
