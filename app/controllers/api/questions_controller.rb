class Api::QuestionsController < Api::BaseController

  def show
    question = Question.friendly.find(params[:id])

    respond_to do |format|
      format.json do
        render :json => {
          title: question.title,
          text: question.text,
          creator: question.creator.try(:name),
          resource_url: resource_url(question),
          answers: question.answers.map{|answer| {answer_text: answer.text, creator: answer.creator.try(:name)} }
        }
      end
    end
  end

end
