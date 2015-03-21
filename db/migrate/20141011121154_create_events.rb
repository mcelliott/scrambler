class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :event_date
      t.string  :name
      t.integer :team_size
      t.timestamps null: false
    end
  end
end
