class AddEmailCountToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :email_count, :integer, default: 0
  end
end
