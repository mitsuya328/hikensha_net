require 'rails_helper'

RSpec.describe "UsersDestroys", type: :request do
  let!(:user) { FactoryBot.create(:user, admin: true) }
  let!(:other_user) { FactoryBot.create(:user, email: "archer@example.com") }

  it "should redirect destroy when not logged in" do
    expect{
      delete user_path(user)
    }.not_to change{ User.count }
    expect(response).to redirect_to login_url
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(other_user)
    expect{
      delete user_path(user)
    }.not_to change{ User.count }
    expect(response).to redirect_to root_url
  end

  it "delete when logged in as a admin" do
    log_in_as(user)
    expect{ 
      delete user_path(other_user)
    }.to change{ User.count }.by(-1)
  end

  it "delete when logged in as a correct user" do
    log_in_as(other_user)
    expect{
      delete user_path(other_user)
    }.to change{ User.count }.by(-1)
  end
end
