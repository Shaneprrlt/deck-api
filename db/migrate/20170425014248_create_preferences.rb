class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.references :user, foreign_key: true
      t.jsonb :app
      t.jsonb :notifications

      t.timestamps
    end
  end
end
