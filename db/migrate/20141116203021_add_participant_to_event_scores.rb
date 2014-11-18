class AddParticipantToEventScores < ActiveRecord::Migration
  def change
    add_column :event_scores, :participant_id, :integer
  end
end
