require 'rails_helper'

feature %(
  As a user
  I want to view a specific tutorial
  So that I can learn more about it
) do
  scenario 'user views specific tutorial' do
    tutorial = FactoryGirl.create(:tutorial)
    visit tutorial_path(tutorial)
    expect(page).to have_content(tutorial.url)
  end
end
