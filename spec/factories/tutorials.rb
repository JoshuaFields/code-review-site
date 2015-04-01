FactoryGirl.define do
  factory :tutorial do
    sequence(:title) {|n| "Tutorial#{n}"}
    sequence(:url) {|n| "http://www.an-tutorial#{n}.com"}
    language 'Ruby'
    description 'A tutorial'
    organization 'Code School?'
    cost "$"
  end
end
