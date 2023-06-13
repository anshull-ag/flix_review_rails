class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user_name
    remove_column :users, :user
    remove_column :users, :default
  end
end
