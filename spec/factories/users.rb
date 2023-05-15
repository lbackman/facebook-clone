FactoryBot.define do
  factory :user do
    email { |n| "user_#{n}@email_provider.com" }
    password { 'pass123' }
    
    
    after(:create) do |user|
      create(:user_information, user_id: user.id)

      # You may need to reload the record here, depending on your application
      user.reload
    end
    
  end
end
