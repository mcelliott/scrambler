class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :event_id
      t.string  :name
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
