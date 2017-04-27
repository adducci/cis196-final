class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :tmdb_id

      t.timestamps null: false
    end
  end
end
