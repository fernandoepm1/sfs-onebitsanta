FactoryBot.define do
  factory :gathering do
    title       { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    user
  end
end
