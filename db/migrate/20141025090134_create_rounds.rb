class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :round_number
      t.timestamps
    end
  end
end
