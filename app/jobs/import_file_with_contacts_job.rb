# frozen_string_literal: true

class ImportFileWithContactsJob
  include Sidekiq::Worker

  sidekiq_options retry: 1

  def perform(contact_file_id, column_order)
    contact_file = ContactFile.find(contact_file_id)

    contact_file.processing!

    ImportFileToContacts.call(contact_file: contact_file, column_order: column_order)
  end
end
