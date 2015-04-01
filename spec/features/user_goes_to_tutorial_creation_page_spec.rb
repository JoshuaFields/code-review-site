require 'rails_helper'

feature 'user accesses tutorial creation page', %{
  As a user
  I want to access the new page for tutorials
  So that I can add a tutorial
} do
  scenario 'click on link button to new tutorial page' do
    visit tutorials_path
    click_link 'Add Tutorial'
    expect(page).to have_content('Add a Tutorial')
  end
end
