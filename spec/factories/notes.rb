FactoryBot.define do
  factory :note do
    text { Faker::Lorem.paragraph }
    video_time { Faker::Number.number(digits: 3) }
    
    association :user
    association :book
  end
end
