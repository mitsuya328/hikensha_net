require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do
  let(:user){ FactoryBot.create(:user) }

  it "with invalid information" do
    get login_path
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template 'sessions/new'
    expect(logged_in?).to be_falsey
    expect(flash).to be_any
    get root_path
    expect(flash).to be_empty
  end

  it "with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    user.email,
                                          password: 'password' } }
    expect(logged_in?).to be_truthy
    expect(response).to redirect_to user
    delete logout_path
    expect(logged_in?).to be_falsey
    expect(response).to redirect_to root_path
  end
end
