class AddRemovedToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :removed, :boolean, null: false, default: false
  end
end
