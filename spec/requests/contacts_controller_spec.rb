# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController do
  before { sign_in user }

  let(:user) { create(:user) }

  describe '#index' do
    subject(:get_contacts_path) { get contacts_path }

    let!(:contacts) { create_list(:contact, 2, user: user) }

    it 'assign contacts and return ok status' do
      get_contacts_path

      expect(assigns(:contacts)).to match_array(contacts)
      expect(response).to have_http_status(:ok)
    end
  end
end
