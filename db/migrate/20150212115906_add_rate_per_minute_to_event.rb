class AddRatePerMinuteToEvent < ActiveRecord::Migration
  def change
    add_column :events, :rate_per_minute, :numeric, default: 0.0
  end
end
