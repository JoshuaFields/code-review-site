require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  it { should belong_to :user }

  it { should have_valid(:title).when("Ruby Wars") }
  it { should have_valid(:url).when("https://rubywars.com") }
  it { should have_valid(:language).when("Ruby") }
  it { should have_valid(:organization).when("Code Wars") }
  it { should have_valid(:description).when("A great resource!") }
  it { should have_valid(:cost).when("$$$$") }
  it { should have_valid(:user).when(FactoryGirl.create(:user)) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :url }
  it { should validate_presence_of :language }
  it { should validate_presence_of :user }

  it { should validate_length_of :title }
  it { should validate_length_of :url }
  it { should validate_length_of :language }
  it { should validate_length_of :organization }
  it { should validate_length_of :description }

  it { should validate_inclusion_of(:cost).in_array(%w(Free $ $$ $$$ $$$$)) }
end

describe "#all_tags" do
  it "should have all tags" do
    tutorial = FactoryGirl.create(:tutorial, all_tags: "ruby, html")
    expect(tutorial.all_tags).to eq("ruby, html")
  end
end

describe "#all_tags=(names)" do
  it "should add to database" do
    tutorial = FactoryGirl.create(:tutorial)
    tutorial.all_tags=("assandra")
    expect(Tag.where(tag_name: "assandra")).to exist
  end
end

describe "#tagged_with" do
  it "should return tutorials with tag name" do
    tutorial = FactoryGirl.create(:tutorial, all_tags: "ruby, html")
    expect(Tutorial.tagged_with("ruby")[0][:title]).to eq tutorial.title
  end
end
