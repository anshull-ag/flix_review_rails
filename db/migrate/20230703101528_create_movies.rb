class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :rating
      t.string :description
      t.date :released_date
      t.string :star_cast
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
