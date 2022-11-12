# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :date_of_birth, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :credit_card_number, null: false
      t.string :credit_card_network, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
