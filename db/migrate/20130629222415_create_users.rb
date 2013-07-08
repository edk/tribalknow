class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :name
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
