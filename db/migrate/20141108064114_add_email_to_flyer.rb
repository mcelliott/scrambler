class AddEmailToFlyer < ActiveRecord::Migration
  def change
    add_column :flyers, :email, :string
  end
end
