# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :contacts
  
  root to: 'contacts#index'
end
