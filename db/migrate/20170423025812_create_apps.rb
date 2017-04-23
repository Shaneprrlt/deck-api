class CreateApps < ActiveRecord::Migration[5.0]

  # Note: Since Apps Reference an Untenented Platform Object
  # We cannot add a foreign key constraint to the platform id
  #
  # More Information: https://github.com/influitive/apartment/issues/248
  
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :platform_id

      t.timestamps
    end
  end
end
