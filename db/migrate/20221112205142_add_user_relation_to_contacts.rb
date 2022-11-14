# frozen_string_literal: true

class AddUserRelationToContacts < ActiveRecord::Migration[7.0]
  def change
    add_reference :contacts, :user
  end
end
