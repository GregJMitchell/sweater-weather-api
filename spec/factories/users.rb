FactoryBot.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
    api_key { SecureRandom.base64.tr('+/=', 'Qrt') }
  end
end
