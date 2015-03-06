class ChangeHoursToIntegerOnFlyer < ActiveRecord::Migration
  def change
    change_column :flyers, :hours, :integer, default: 0;
  end
end
