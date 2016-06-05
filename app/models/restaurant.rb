class Restaurant < ActiveRecord::Base
  has_many :restaurant_comments

  def to_s
    name
  end
end
