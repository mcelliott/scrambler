class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.date :completed_at
      t.decimal :amount
      t.integer :event_id
      t.integer :participant_id
      t.timestamps null: false
    end
  end
end
