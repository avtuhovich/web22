class CreateBia < ActiveRecord::Migration[7.0]
  def change
    create_table :bia do |t|
      t.string :name
      t.integer :agent_id

      t.timestamps
    end
  end
end
