# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :name, :date_of_birth, :phone, :address, :credit_card_number, :credit_card_network, :email, presence: true
  validates :name, format: {
    with: /\A[a-zA-Z\s-]+\z/,
    message: 'Only letters, spaces and hyphens are allowed.'
  }
  validate :date_of_birth
  validates :phone, format: {
    with: /\A(\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2})|
          (\(\+\d{2}\)\s\d{3}-\d{3}-\d{2}-\d{2})\z/x
  }
  validate :date_of_birth_format

  private

  def date_of_birth_format
    return if Date._iso8601(date_of_birth).present?

    errors.add(:date_of_birth, 'Invalid format. Use ISO8601 format.')
  end
end
