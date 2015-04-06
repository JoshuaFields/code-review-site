require 'rails_helper'

feature 'admin signs in', %(
  As an admin
  I want to sign in
  So that I can edit content
) do
  let(:test_admin) { FactoryGirl.create(:admin) }
  let(:user_one) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user) }

  scenario 'specify valid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: test_admin.email
    fill_in 'Password', with: test_admin.password

    click_button 'Log in'

    expect(page).to have_content('Admin signed in successfully')

    visit users_path

    expect(page).to have_content(user_one.email)
    expect(page).to have_content(user_two.email)
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: user_one.email
    fill_in 'Password', with: user_one.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    visit users_path

    expect(page).to have_content('Must be an admin!')
    expect(page).to_not have_content(user_one.email)
  end
end
