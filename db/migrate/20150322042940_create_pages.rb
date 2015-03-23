class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.string :name

      t.timestamps null: false
    end
    add_index :pages, :slug, unique: true
  end
end
