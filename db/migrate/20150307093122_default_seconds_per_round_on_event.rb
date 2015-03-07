class DefaultSecondsPerRoundOnEvent < ActiveRecord::Migration
  def change
    change_column :events, :time_per_round, :decimal, default: 60.0
  end
end
