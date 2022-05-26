class Unique < ActiveRecord::Migration[7.0]
  def change
    add_index :agents, :name, :unique => true
    add_index :bia, :name, :unique => true
  end
end
