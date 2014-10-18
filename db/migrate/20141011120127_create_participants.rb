class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :flyer_id
      t.integer :category_id
      t.integer :team_id
      t.integer :event_id
      t.timestamps
    end
  end
end
