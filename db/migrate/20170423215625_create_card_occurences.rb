class CreateCardOccurences < ActiveRecord::Migration[5.0]
  def change
    create_table :card_occurences do |t|
      t.references :user, foreign_key: true
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
