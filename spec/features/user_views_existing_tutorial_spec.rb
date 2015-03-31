require 'rails_helper'

feature %q(As a user, I want to view a specific tutorial
  ) do
  scenario 'user views specific tutorial' do
    FactoryGirl.create(:tutorial)
    visit tutorial_path('1')
    expect(page).to have_content('http://www.1.com')
  end
end
