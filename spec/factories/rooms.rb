FactoryBot.define do
  factory :room do
    name { Faker::Lorem.sentence }
  end
end
