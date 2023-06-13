class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :username, :user_name
  end
end
