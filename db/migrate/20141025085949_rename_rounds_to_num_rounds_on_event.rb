class RenameRoundsToNumRoundsOnEvent < ActiveRecord::Migration
  def change
    rename_column :events, :rounds, :num_rounds
  end
end
