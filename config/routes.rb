# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web, at: "/sidekiq"

  resources :contacts, only: %i[index]
  resources :contact_files, only: %i[new create index]

  root to: "contacts#index"
end
