class AddNameToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :name, :string
  end
end
