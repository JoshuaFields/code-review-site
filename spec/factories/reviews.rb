FactoryGirl.define do
  factory :review do
    rating 5
    body "It's amazing!"
    tutorial
    user
  end
end
