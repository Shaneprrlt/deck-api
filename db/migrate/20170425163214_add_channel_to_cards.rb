class AddChannelToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :channel, :string
  end
end
