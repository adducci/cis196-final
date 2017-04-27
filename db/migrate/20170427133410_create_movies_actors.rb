class CreateMoviesActors < ActiveRecord::Migration
  def change
    create_table :movies_actors do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
