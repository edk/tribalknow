class Answer < ActiveRecord::Base
  belongs_to :question
  validates  :text, presence: true, length: { minimum: 3 }

  searchable do
    text :text
  end
end
