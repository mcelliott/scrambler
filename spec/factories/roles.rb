FactoryGirl.define do
  factory :role do
    name 'manager'

    trait :admin do
      name 'admin'
    end
  end
end
