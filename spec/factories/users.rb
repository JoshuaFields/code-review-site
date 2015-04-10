FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "user#{n}"}
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    factory :user_with_photo do
      profile_photo { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/images/Bowser.png") }
    end
  end
end
