class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :path
      t.integer :user_id
      t.integer :bia_id
      t.integer :likes

      t.timestamps
    end
  end
end
