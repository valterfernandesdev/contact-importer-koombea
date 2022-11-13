class ImportFileToContacts < ApplicationService
  require "csv"

  attr_reader :contact_file, :column_order, :imported_contacts

  def initialize(contact_file:, column_order:)
    @contact_file = contact_file
    @column_order = column_order.split(",")
    @imported_contacts = []
  end

  def call
    CSV.parse(contact_file.file.download).tap(&:shift).each_with_index do |content, index|
      contact = build_contact(content)

      imported_contacts << contact

      next if contact.save

      contact_file.update!(log: log_message(contact, index))
    end

    return contact_file.failed! unless any_contact_persisted?

    contact_file.finished!
  end

  private

  def build_contact(content)
    contact = Contact.new(user: contact_file.user)

    contact.name = content[column_order.index("name")] if column_order.index("name").present?
    contact.date_of_birth = content[column_order.index("date_of_birth")] if column_order.index("date_of_birth").present?
    contact.phone = content[column_order.index("phone")] if column_order.index("phone").present?
    contact.address = content[column_order.index("address")] if column_order.index("address").present?
    contact.credit_card_number = content[column_order.index("credit_card_number")] if column_order.index("credit_card_number").present?
    contact.email = content[column_order.index("email")] if column_order.index("email").present?

    contact
  end

  def log_message(contact, index)
    error_message = "Line #{index + 2} failed to import with error: #{contact.errors.full_messages.join(', ')};"

    return contact_file.log.concat("#{error_message}") if contact_file.log.present?

    error_message
  end

  def any_contact_persisted?
    imported_contacts.any?(&:persisted?)
  end
end