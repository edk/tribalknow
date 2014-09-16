class Notification < ActiveRecord::Base
  has_many :user_notifications
end
