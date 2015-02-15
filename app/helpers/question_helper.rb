module QuestionHelper
  include ActsAsTaggableOn::TagsHelper

  def archive_question(question)
    if question.creator == current_user
      # show deletion element
      icon = f_icon 'x-circle', size: '1.5em', style: ''
      link_to icon, question_path(question), method: :delete, class: 'icon_link', title: 'Delete'
    end
  end

  def archive_answer(answer)
    if answer.creator == current_user
      # show deletion element
      icon = f_icon 'x-circle', size: '1.5em', style: ''
      link_to icon, question_answer_path(answer.question, answer), method: :delete, class: 'icon_link left_of_answer', title: 'Delete'
    end
  end

end
