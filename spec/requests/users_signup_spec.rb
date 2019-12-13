require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  it "invalid signup information" do
    get signup_path
    expect{
      post signup_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    }.not_to change { User.count }
    expect(response).to render_template 'users/new'
  end

  it "valid signupu information" do
    get signup_path
    expect{
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    }.to change { User.count }.by(1) 
    #expect(response).to redirect_to user_path(assigns(:user))
    #expect(flash[:success]).to be_truthy
    #expect(logged_in?).to be_truthy
  end
end
