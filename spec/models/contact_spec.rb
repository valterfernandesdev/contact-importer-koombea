# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact do
  subject(:contact) { build(:contact) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :date_of_birth }
    it { is_expected.to validate_presence_of :phone }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :credit_card_number }
    it { is_expected.to validate_presence_of :email }

    describe 'validating name format' do
      context 'when name is valid' do
        before { contact.name = ['John-Doe', 'Valter Filho'].sample }

        it { is_expected.to be_valid }
      end

      context 'when name is invalid' do
        before { contact.name = ['John-Doe!', 'Valter.Filho'].sample }

        it { is_expected.to be_invalid }
      end
    end

    describe 'validating phone format' do
      context 'when phone is valid' do
        before { contact.phone = ['(+57) 320 432 05 09', '(+57) 320-432-05-09'].sample }

        it { is_expected.to be_valid }
      end

      context 'when phone is invalid' do
        before { contact.phone = ['+552241478855', '(+1) 4221 455 21'].sample }

        it { is_expected.to be_invalid }
      end
    end

    describe 'validating date_of_birth format' do
      context 'when date_of_birth is valid' do
        before { contact.date_of_birth = %w[2001-02-09 19930205].sample }

        it { is_expected.to be_valid }
      end

      context 'when date_of_birth is invalid' do
        before { contact.date_of_birth = ['05/02/1993', '05-02-1982'].sample }

        it { is_expected.to be_invalid }
      end
    end

    describe 'validating email format' do
      context 'when email is valid' do
        before { contact.email = %w[valter@test.com v@v].sample }

        it { is_expected.to be_valid }
      end

      context 'when email is invalid' do
        before { contact.email = ['dasdsad', 'dsadas@'].sample }

        it { is_expected.to be_invalid }
      end
    end
  end
end
