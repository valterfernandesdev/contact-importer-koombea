class ContactFilesController < ApplicationController
  def new
    @contact_file = ContactFile.new
  end

  def create; end
end
