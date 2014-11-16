class CreateEventScores < ActiveRecord::Migration
  def change
    create_table :event_scores do |t|
      t.integer :team_participant_id
      t.integer :event_id
      t.integer :score
      t.integer :round_id
      t.integer :user_id

      t.timestamps
    end
  end
end
