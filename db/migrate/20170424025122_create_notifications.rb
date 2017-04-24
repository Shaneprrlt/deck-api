class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :action
      t.references :actor, polymorphic: true
      t.references :target, polymorphic: true
      t.boolean :read, null: false, default: false
      t.string :uuid

      t.timestamps
    end
  end
end
