FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user_#{n}@exampble.com"
    end
    password { SecureRandom.uuid }
  end
end
