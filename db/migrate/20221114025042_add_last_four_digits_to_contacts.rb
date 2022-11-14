# frozen_string_literal: true

class AddLastFourDigitsToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :credit_card_last_four_digits, :string
  end
end
