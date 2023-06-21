class AddCategoryIdToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :catogery_id, :integer
  end
end
