class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name,       null: false
      t.string :last_name
      t.string :phone
      t.string :cellphone
      t.string :address
      t.references :agenda, index: true

      t.timestamps null: false
    end
    add_foreign_key :contacts, :agendas
  end
end
