class CreateCardFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :card_followers do |t|
      t.references :card, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
