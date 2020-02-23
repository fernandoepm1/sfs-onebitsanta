FactoryBot.define do
  factory :party do
    user
    title       { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    location { "#{FFaker::Address.city}, #{FFaker::Address.street_address}" }
    event_date { FFaker::Time.date }
    event_hour { rand(24).to_s }
  end
end
