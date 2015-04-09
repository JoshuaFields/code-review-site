require "rails_helper"
require "users_controller"

describe UsersController, type: :controller do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user) }

  it "should display page to admin" do
    sign_in admin
    get(:index)
    expect(response.code).to eq "200"
  end

  it "should redirect non-admin" do
    sign_in user
    get(:index)
    expect(response.code).to eq "302"
  end
end
