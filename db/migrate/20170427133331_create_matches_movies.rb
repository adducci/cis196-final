class CreateMatchesMovies < ActiveRecord::Migration
  def change
    create_table :matches_movies do |t|
      t.references :match, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
