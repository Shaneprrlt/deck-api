class AddChannelToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :channel, :string
  end
end
