FactoryGirl.define do
  factory :tutorial do
    sequence(:title) {|n| "Tutorial#{n}"}
    sequence(:url) {|n| "http://www.#{n}.com"}
    language 'Ruby'
  end
end