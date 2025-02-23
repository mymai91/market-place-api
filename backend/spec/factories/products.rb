FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    published { Faker::Boolean.boolean }
    association :user

    trait :tivi do
      title { 'Plasma Samsung tv' }
    end
    
    trait :phone do
      title { 'Samsung phone' }
    end

    trait :laptop do
      title { 'Macbook pro' }
    end
  end
end
