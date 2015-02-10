class AddParticipantCostToEvent < ActiveRecord::Migration
  def change
    add_column :events, :participant_cost, :numeric
  end
end
