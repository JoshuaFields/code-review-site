require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it { should have_many :reviews }

  it { should have_valid(:title).when("Ruby Wars") }
  it { should have_valid(:url).when("https://rubywars.com") }
  it { should have_valid(:language).when("Ruby") }
  it { should have_valid(:organization).when("Code Wars") }

  it { should_not have_valid(:title).when("") }
  it { should_not have_valid(:url).when("") }
  it { should_not have_valid(:language).when("") }
  it { should_not have_valid(:organization).when("") }

  it { should have_many(:reviews).dependent(:destroy) }
end
