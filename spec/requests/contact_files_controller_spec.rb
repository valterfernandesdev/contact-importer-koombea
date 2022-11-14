# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactFilesController do
  before { sign_in user }

  let(:user) { create(:user) }

  describe '#index' do
    subject(:get_contact_files_path) { get contact_files_path }

    before do
      contact_files
      user.contact_files << contact_files
    end

    let(:contact_files) { create_list(:contact_file, 2, user: user) }

    it 'assign contact files and return ok status' do
      get_contact_files_path

      expect(assigns(:contact_files)).to match_array(contact_files)
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#new' do
    subject!(:get_new_contact_file_path) { get new_contact_file_path }

    it { expect(response).to have_http_status :ok }
  end

  describe '#create' do
    subject(:post_contact_files_path) { post contact_files_path, params: params }

    let(:params) do
      {
        contact_file: { file: fixture_file_upload('valid_contacts.csv') },
        column_order: %w[name date_of_birth phone address credit_card email]
      }
    end

    it 'creates contact file' do
      expect { post_contact_files_path }.to change(ContactFile, :count).by 1
    end

    it 'creates attachment for the uploaded file' do
      expect { post_contact_files_path }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    it 'enqueues ImportFileWithContactsJob' do
      post_contact_files_path

      expect(ImportFileWithContactsJob)
        .to have_enqueued_sidekiq_job(ContactFile.first.id, params[:column_order])
    end

    it 'displays flash notice and redirects to contact_files_path' do
      post_contact_files_path

      expect(flash[:notice]).to eq 'File is being processed. Wait a few minutes and refresh the page.'
      expect(response).to redirect_to contact_files_path
    end
  end
end
