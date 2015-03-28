class CreateTeamParticipants < ActiveRecord::Migration
  def change
    create_table :team_participants do |t|
      t.integer :event_id
      t.integer :participant_id
      t.boolean :placeholder, default: false
      t.integer :team_id
      t.timestamps null: false
    end
  end
end
