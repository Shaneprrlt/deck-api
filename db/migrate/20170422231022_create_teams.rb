class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :subdomain
      t.string :email
      t.string :timezone
      t.boolean :blocked, null: false, default: false

      t.timestamps
    end
  end
end
