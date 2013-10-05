class Question < ActiveRecord::Base
  has_many :answers

  validates  :title, :text, presence: true, length: { minimum: 3 }
end
