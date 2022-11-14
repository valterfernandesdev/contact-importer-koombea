# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportFileWithContactsJob do
  describe '#perform' do
    subject(:perform) { described_class.new.perform(contact_file_id, column_order) }

    let(:column_order) { 'name,date_of_birth,phone,address,credit_card_number,email' }

    context 'when contact file does not exists' do
      let(:contact_file_id) { Faker::Number.number(digits: 1) }

      it 'raises ActiveRecord::RecordNotFound' do
        expect { perform }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when contact file exists' do
      let(:mocked_service) { instance_double(ImportFileToContacts) }
      let(:contact_file) { create(:contact_file, file: fixture_file_upload('valid_contacts.csv')) }
      let(:contact_file_id) { contact_file.id }

      it 'updates file status to processing and calls ImportFileToContacts service' do
        expect(ImportFileToContacts).to receive(:call).with(contact_file: contact_file, column_order: column_order)

        perform

        expect(contact_file.reload).to be_processing
      end
    end
  end
end
