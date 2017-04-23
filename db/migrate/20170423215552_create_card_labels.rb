class CreateCardLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :card_labels do |t|
      t.references :card, foreign_key: true
      t.references :label, foreign_key: true

      t.timestamps
    end
  end
end
