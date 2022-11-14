# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportFileToContacts do
  describe '#call' do
    subject(:call) { described_class.call(contact_file: contact_file, column_order: column_order) }

    context 'when file is valid' do
      let(:contact_file) { create(:contact_file, file: fixture_file_upload('valid_contacts.csv')) }
      let(:column_order) { 'name,date_of_birth,phone,address,credit_card_number,email' }

      let(:expected_contacts) do
        [
          Contact.find_by(name: 'Valter Filho'),
          Contact.find_by(name: 'Test Name')
        ]
      end

      it 'creates contacts' do
        aggregate_failures do
          expect { call }.to change(Contact, :count).by 2
          expect(Contact.all).to match_array expected_contacts
        end
      end

      it 'changes file status to finished' do
        call

        expect(contact_file).to be_finished
      end

      it 'does not set log' do
        call

        expect(contact_file.log).to be_blank
      end
    end

    context 'when file has one invalid contact and one valid' do
      let(:contact_file) { create(:contact_file, file: fixture_file_upload('with_few_invalid_contacts.csv')) }
      let(:column_order) { 'name,date_of_birth,phone,address,credit_card_number,email' }

      it 'creates contacts' do
        expect { call }.to change(Contact, :count).by 1
      end

      it 'changes file status to finished' do
        call

        expect(contact_file).to be_finished
      end

      it 'sets log error for the first contact in the file' do
        call

        expect(contact_file.log).to eq(
          'Line 2 failed to import with error: Name Only letters, spaces and hyphens are allowed, ' \
          'Phone is invalid, Email is invalid;'
        )
      end
    end

    context 'when column order have a different order' do
      let(:contact_file) do
        create(:contact_file, status: :processing, file: fixture_file_upload('with_diff_column_order.csv'))
      end
      let(:column_order) { 'name,phone,credit_card_number,address,email,date_of_birth' }

      let(:expected_contacts) do
        [
          Contact.find_by(name: 'Valter Filho', date_of_birth: '19930205'),
          Contact.find_by(name: 'Test Name')
        ]
      end

      it 'creates contacts' do
        aggregate_failures do
          expect { call }.to change(Contact, :count).by 2
          expect(Contact.all).to match_array expected_contacts
        end
      end

      it 'changes file status to finished' do
        call

        expect(contact_file).to be_finished
      end

      it 'does not set log' do
        call

        expect(contact_file.log).to be_blank
      end
    end
  end
end
