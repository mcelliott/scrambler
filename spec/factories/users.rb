FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    sequence(:email) { |n| "test_#{n}@example.com" }
    password "please123"
    password_confirmation "please123"
    role

    trait :admin do
      role { create(:role, :admin) }
    end
  end
end
