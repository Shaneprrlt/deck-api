class CreateCardTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :card_types do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
