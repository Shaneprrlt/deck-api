class CreateDeckLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :deck_labels do |t|
      t.references :deck, foreign_key: true
      t.references :label, foreign_key: true

      t.timestamps
    end
  end
end
