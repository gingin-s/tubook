FactoryBot.define do
  factory :book do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    youtube_id { 'AAA-bb12345' }
  end
end
