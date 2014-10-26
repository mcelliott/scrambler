class AddRoundIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :round_id, :integer
  end
end
