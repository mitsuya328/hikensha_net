require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  before { ActionMailer::Base.deliveries.clear }

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

  it "valid signupu information with account activation" do
    get signup_path
    expect{
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    }.to change { User.count }.by(1) 
    expect(ActionMailer::Base.deliveries.size).to eq 1
    user = assigns(:user)
    expect(user).not_to be_activated
    #有効化されていない状態でログインしてみる
    log_in_as(user)
    expect(is_logged_in?).to be_falsey
    #有効化トークンが不正な場合
    get edit_account_activation_path("invalid token", email: user.email)
    expect(is_logged_in?).to be_falsey
    #トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    expect(is_logged_in?).to be_falsey
    #有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.reload).to be_activated
    expect(response).to redirect_to user_path(user)
    expect(is_logged_in?).to be_truthy
  end
end
