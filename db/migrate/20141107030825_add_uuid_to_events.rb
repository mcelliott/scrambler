class AddUuidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :uuid, :uuid, default: 'uuid_generate_v4()'
  end
end
