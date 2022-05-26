class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_token

      t.index :remember_token
      t.index :email, unique: true
      t.timestamps
    end
  end
end
