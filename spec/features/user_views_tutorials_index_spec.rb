require 'pry'
require 'rails_helper'

feature 'As a user, I want to view all the tutorials' do
  scenario 'User views index page for tutorials' do
    FactoryGirl.create(:tutorial)
    FactoryGirl.create(:tutorial)
    visit tutorials_path
    expect(page).to have_content('Tutorial2')
    expect(page).to have_content('Tutorial3')
  end
end