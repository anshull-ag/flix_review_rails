class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :rating
      t.string :description
      t.string :release_date

      t.timestamps
    end
  end
end
