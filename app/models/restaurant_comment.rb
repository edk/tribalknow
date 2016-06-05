class RestaurantComment < ActiveRecord::Base
  belongs_to :restaurant
  acts_as_nested_set
end
