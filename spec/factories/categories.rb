# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    category_type CategoryType::FREEFLY

    trait :head_up_freefly do
      name 'head_up'
      category_type CategoryType::FREEFLY
    end

    trait :head_down_freefly do
      name 'head_down'
      category_type CategoryType::FREEFLY
    end

    trait :freefly do
      name 'head_down'
      category_type CategoryType::FREEFLY
    end

    trait :belly do
      name 'belly'
      category_type CategoryType::BELLY
    end

    trait :mixed do
      name 'mixed'
      category_type CategoryType::MIXED
    end
  end
end
