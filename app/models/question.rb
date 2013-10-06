
class Question < ActiveRecord::Base
  stampable

  simple_tagging

  has_many :answers

  validates  :title, :text, presence: true, length: { minimum: 3 }

  searchable do
    text :title, :text
    text :tags do
      tags.join(', ')
    end
  end

end
