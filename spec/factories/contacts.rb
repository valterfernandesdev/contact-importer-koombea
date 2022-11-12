# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    user
    name { Faker::Movies::StarWars.character }
    date_of_birth { Faker::Date.between(from: '1977-11-18', to: '1993-02-05') }
    phone { '(+57) 320 432 05 09' }
    address { Faker::Address.full_address }
    credit_card_number { Faker::Stripe.valid_card(card_type: 'visa_debit') }
    credit_card_network { 'Visa' }
    email { Faker::Internet.unique.email }
  end
end
