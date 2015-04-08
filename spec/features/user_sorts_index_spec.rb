require "rails_helper"

feature %(
  As a user
  I want to sort the index page by clicking on one of the many sorting buttons
  So that I can only see tutorials with specific attributes
) do

  scenario "user sorts index page by clicking on a tag" do
    tutorial = FactoryGirl.create(:tutorial)
    visit tutorials_path
    click_link "ruby"
    expect(page).to have_content(tutorial.title)
  end

  scenario "user sorts index page by clicking on newest" do
    tutorial1 = FactoryGirl.create(:tutorial)
    tutorial2 = FactoryGirl.create(:tutorial)

    visit tutorials_path
    click_link "Newest"
    Tutorial.order('created_at desc').all.should == [tutorial2, tutorial1]
  end

  scenario "user sorts index page by clicking on oldest" do
    tutorial1 = FactoryGirl.create(:tutorial)
    tutorial2 = FactoryGirl.create(:tutorial)

    visit tutorials_path
    click_link "Oldest"
    Tutorial.order('created_at asc').all.should == [tutorial1, tutorial2]
  end
end
