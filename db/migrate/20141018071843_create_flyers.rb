class CreateFlyers < ActiveRecord::Migration
  def change
    create_table :flyers do |t|
      t.decimal :hours
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
