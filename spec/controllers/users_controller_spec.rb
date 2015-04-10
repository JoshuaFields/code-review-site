require "rails_helper"
require "users_controller"

describe UsersController, type: :controller do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user, admin: false) }

  it "should display page to admin" do
    sign_in admin
    get(:index)
    expect(response.code).to eq "200"
  end

  it "should redirect non-admin" do
    sign_in user
    get(:index)
    expect(response.code).to eq "302"
    expect(response.body).to include tutorials_path
    expect(flash[:notice]).to eq "This page requires admin privileges!"
  end
end
