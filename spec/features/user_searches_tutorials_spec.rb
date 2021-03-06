require "rails_helper"

feature %(
  As a user
  I want to search the tutorials
  So that I can find the one I'm looking for
) do
  before(:each) do
    FactoryGirl.create(:tutorial, title: "Great title!")
    FactoryGirl.create(:tutorial, title: "Overall TITLE Awesomeness!")
    FactoryGirl.create(:tutorial, title: "Improved titleness!")
  end

  scenario "Search term exactly matches" do
    visit tutorials_path
    fill_in :search, with: "title"
    click_button "Search"
    expect(page).to have_content("Great Title!")
    expect(page).to have_content("Overall Title Awesomeness!")
    expect(page).to have_content("Improved Titleness!")
  end

  scenario "Search term is a near-match" do
    visit tutorials_path
    fill_in :search, with: "titling"
    click_button "Search"
    expect(page).to have_content("Great Title!")
    expect(page).to have_content("Overall Title Awesomeness!")
    expect(page).to have_content("Improved Titleness!")
  end

  scenario "Search term is not a match" do
    visit tutorials_path
    fill_in :search, with: "adfjksdfks"
    click_button "Search"
    expect(page).to have_no_content("Great Title!")
    expect(page).to have_no_content("Overall Title Awesomeness!")
    expect(page).to have_no_content("Improved Titleness!")
  end

  scenario "Destructive SQL query" do
    visit tutorials_path
    fill_in :search, with: "a');DROP TABLE tutorials;--"
    click_button "Search"
    visit tutorials_path
    expect(page).to have_content("Great Title!")
    expect(page).to have_content("Overall Title Awesomeness!")
    expect(page).to have_content("Improved Titleness!")
  end
end
