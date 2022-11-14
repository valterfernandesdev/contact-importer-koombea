# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  validates :name, :date_of_birth, :phone, :address, :credit_card_number, :credit_card_network, :email, presence: true
  validates :name, format: {
    with: /\A[a-zA-Z\s-]+\z/,
    message: "Only letters, spaces and hyphens are allowed"
  }
  validate :date_of_birth
  validates :phone, format: {
    with: /\A(\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2})|
          (\(\+\d{2}\)\s\d{3}-\d{3}-\d{2}-\d{2})\z/x
  }
  validate :date_of_birth_format

  before_validation :credit_card_network_from_card_number
  after_validation :encrypt_credit_card_number

  validates :email, uniqueness: { scope: :user_id }, format: { with: Devise.email_regexp }

  private

  def date_of_birth_format
    return if Date._iso8601(date_of_birth).present?

    errors.add(:date_of_birth, "Invalid format. Use ISO8601 format")
  end

  def credit_card_network_from_card_number
    self.credit_card_network = CreditCardValidations::Detector.new(credit_card_number).brand_name
  end

  def encrypt_credit_card_number
    self.credit_card_last_four_digits = credit_card_number.to_s&.last(4)
    self.credit_card_number = BCrypt::Password.create(credit_card_number)
  end
end
