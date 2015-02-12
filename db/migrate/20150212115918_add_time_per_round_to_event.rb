class AddTimePerRoundToEvent < ActiveRecord::Migration
  def change
    add_column :events, :time_per_round, :numeric, default: 1.0
  end
end
