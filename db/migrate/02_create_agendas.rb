class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :agendas, :users
  end
end
