FactoryBot.define do
  factory :chat_message do
    text { Faker::Lorem.paragraph }
    association :user
    association :room
  end
end
