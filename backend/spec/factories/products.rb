FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    published { Faker::Boolean.boolean }
    association :user
  end
end
