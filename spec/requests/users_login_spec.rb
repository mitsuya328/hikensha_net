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

  it "with valid information" do
    get login_path
    post login_path, params: { session: { email:    user.email,
                                          password: 'password' } }
    expect(response).to redirect_to user
    expect(logged_in?).to be_truthy
  end
end
