class Question < ActiveRecord::Base
  stampable

  scope :any_tags, -> (tags){where('tags && ARRAY[?]', tags)}
  scope :all_tags, -> (tags){where('tags @> ARRAY[?]', tags)}

  has_many :answers

  validates  :title, :text, presence: true, length: { minimum: 3 }

  searchable do
    text :title, :text
    text :tags do
      tags.join(', ')
    end
  end
end
