class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name, null: false
      t.string :domain, null: false
      t.string :database, null: false
      t.boolean :enabled, default: false, null: false

      t.timestamps null: false
    end
  end
end
