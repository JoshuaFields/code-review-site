require 'rails_helper'

feature %(
  As a user
  I want to view only 10 tutorials on the index page
  So that I'm not overwhelmed
) do
  scenario 'user views specific tutorial' do
    11.times { FactoryGirl.create(:tutorial) }

    visit tutorials_path
    expect(page).to have_content("Next › Last »")
  end
end
