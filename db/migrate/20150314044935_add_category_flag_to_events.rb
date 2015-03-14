class AddCategoryFlagToEvents < ActiveRecord::Migration
  def change
    add_column :events, :category_type, :string
  end
end
