class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.integer :round_number
      t.timestamps null: false
    end
  end
end
