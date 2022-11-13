# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :contacts
  resources :contact_files, only: %i[new create]
  
  root to: 'contacts#index'
end
