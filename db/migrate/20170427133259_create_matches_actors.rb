class CreateMatchesActors < ActiveRecord::Migration
  def change
    create_table :matches_actors do |t|
      t.references :match, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
