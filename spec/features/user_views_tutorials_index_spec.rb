require 'rails_helper'

feature %q(
  As a user
  I want to view all the tutorials
  so that I can easily navigate the site
) do
  scenario 'User views index page for tutorials' do
    first_tutorial = FactoryGirl.create(:tutorial)
    second_tutorial = FactoryGirl.create(:tutorial)
    visit tutorials_path
    expect(page).to have_content(first_tutorial.title)
    expect(page).to have_content(second_tutorial.title)
  end
end
