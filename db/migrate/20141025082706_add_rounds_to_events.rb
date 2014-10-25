class AddRoundsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :rounds, :integer
  end
end
