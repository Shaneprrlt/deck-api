class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.boolean :admin, null: false, default: false
      t.boolean :accepted, null: false, default: false
      t.datetime :resent_at

      t.timestamps
    end
  end
end
