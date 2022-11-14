# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "22112211" }
    password_confirmation { "22112211" }
  end
end
