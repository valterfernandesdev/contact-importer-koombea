FactoryBot.define do
  factory :contact_file do
    user
    status { :finished }
  end
end