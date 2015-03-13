class AddEnabledToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :enabled, :boolean
  end
end
