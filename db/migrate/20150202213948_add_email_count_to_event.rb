class AddEmailCountToEvent < ActiveRecord::Migration
  def change
    add_column :events, :email_count, :integer, default: 0
  end
end
