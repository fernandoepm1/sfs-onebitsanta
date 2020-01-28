FactoryBot.define do
  factory :member do
    name  { FFaker::Lorem.word }
    email { FFaker::Internet.email }
    token { '1q2w3e4r5t' }
  end
end
