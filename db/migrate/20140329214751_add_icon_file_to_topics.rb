class AddIconFileToTopics < ActiveRecord::Migration
  def change
    add_attachment :topics, :icon
  end
end
