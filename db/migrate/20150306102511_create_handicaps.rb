class CreateHandicaps < ActiveRecord::Migration
  def change
    create_table :handicaps do |t|
      t.belongs_to :user, null: false
      t.integer  :hours, default: 0
      t.decimal  :amount, default: 0.0
      t.timestamps null: false
    end
  end
end
