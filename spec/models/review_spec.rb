require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :tutorial }
  it { should belong_to :user }

  it { should have_valid(:body).when("It's amazing!") }
  it { should have_valid(:rating).when(5) }
  it { should have_valid(:user).when(FactoryGirl.create(:user)) }

  it { should_not have_valid(:body).when("a") }
  it { should_not have_valid(:body).when("a" * 10000) }
  it { should_not have_valid(:rating).when(50) }

  it { should validate_presence_of :body }
  it { should validate_presence_of :user }

  it { should validate_length_of :body }
  it { should validate_numericality_of :rating }
end
