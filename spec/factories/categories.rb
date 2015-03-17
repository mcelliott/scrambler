# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    category_type CategoryType::FREEFLY

    trait :freefly do
      category_type CategoryType::FREEFLY
    end

    trait :belly do
      category_type CategoryType::BELLY
    end

    trait :mixed do
      category_type CategoryType::MIXED
    end
  end
end
