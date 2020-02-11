FactoryBot.define do
  factory :party do
    title       { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    user
  end
end
