class ChangeStringToBeDateInMovies < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :release_date, :date
    rename_column :movies, :release_date, :released_date
    end
end
