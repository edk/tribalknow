class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.belongs_to :user
      t.belongs_to :notification
      t.boolean :read, :default => false

      t.timestamps
    end
    add_index :user_notifications, [:user_id]
    add_index :user_notifications, [:notification_id]
    add_index :user_notifications, [:user_id, :notification_id]

  end
end
