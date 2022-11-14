# frozen_string_literal: true

class ContactFilesController < ApplicationController
  include ActiveStorage::Blob::Analyzable

  def index
    @contact_files = current_user.contact_files.order(created_at: :desc)
  end

  def new
    @contact_file = ContactFile.new
  end

  def create
    @contact_file = ContactFile.new(contact_file_params)

    @contact_file.save

    ImportFileWithContactsJob.perform_in(5.seconds.from_now, @contact_file.id, params['column_order'])

    redirect_to contact_files_path, notice: 'File is being processed. Wait a few minutes and refresh the page.'
  end

  private

  def contact_file_params
    params.require(:contact_file).permit(:file).merge(user: current_user)
  end
end
