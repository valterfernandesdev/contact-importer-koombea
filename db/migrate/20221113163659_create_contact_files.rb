# frozen_string_literal: true

class CreateContactFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, null: false, default: 'on hold'
      t.text :log

      t.timestamps
    end
  end
end
