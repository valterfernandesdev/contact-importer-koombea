# frozen_string_literal: true

FactoryBot.define do
  factory :contact_file do
    user
    status { :finished }
  end
end
