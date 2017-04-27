class CreateActorsUsers < ActiveRecord::Migration
  def change
    create_table :actors_users do |t|
      t.references :actor, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
