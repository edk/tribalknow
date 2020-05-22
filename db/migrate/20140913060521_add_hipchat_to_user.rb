class AddHipchatToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hipchat_mention_name, :string, :default=>nil
    add_attachment :users, :avatar
  end
end
