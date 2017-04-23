class CreateApps < ActiveRecord::Migration[5.0]
  def change
    create_table :apps do |t|
      t.string :name
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
