class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,          null: false
      t.string :password_digest,   null: false
      t.string :token
      t.boolean :sa,               default: false

      t.timestamps null: false
    end
    add_index :users, :username, unique: true
    add_index :users, :token
    add_index :users, :password_digest
  end
end
