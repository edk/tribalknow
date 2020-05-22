class AddIconFileToTopics < ActiveRecord::Migration[5.2]
  def change
    add_attachment :topics, :icon
  end
end
