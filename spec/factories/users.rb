FactoryBot.define do
  factory :user do
    email { |n| "user_#{n}@email_provider.com" }
    password { 'pass123' }
  end
end
