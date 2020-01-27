FactoryBot.define do
  factory :gathering do
    title      { FFaker::Lorem.word }
    decription { FFaker::Lorem.sentence }
    user
  end
end
