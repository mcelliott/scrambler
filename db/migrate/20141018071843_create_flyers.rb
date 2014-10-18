class CreateFlyers < ActiveRecord::Migration
  def change
    create_table :flyers do |t|
      t.decimal :hours
      t.string :name
      t.timestamps
    end
  end
end
