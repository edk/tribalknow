class Question < ActiveRecord::Base
  has_many :answers

  validates  :text, presence: true, length: { minimum: 3 }
end
