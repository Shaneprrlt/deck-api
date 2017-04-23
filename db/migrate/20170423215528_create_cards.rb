class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.integer :card_type_id
      t.references :app, foreign_key: true
      t.string :title
      t.string :description
      t.integer :state
      t.string :uuid

      t.timestamps
    end
  end
end
