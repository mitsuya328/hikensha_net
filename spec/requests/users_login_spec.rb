require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do
  let(:user){ FactoryBot.create(:user) }

  it "with invalid information" do
    get login_path
    post login_path, params: { session: { email: "", password: "" } }
    expect(response).to render_template 'sessions/new'
    expect(is_logged_in?).to be_falsey
    expect(flash).to be_any
    get root_path
    expect(flash).to be_empty
  end

  it "with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    user.email,
                                          password: 'password' } }
    expect(is_logged_in?).to be_truthy
    expect(response).to redirect_to user
    delete logout_path
    expect(is_logged_in?).to be_falsey
    expect(response).to redirect_to root_path
    # 番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
    expect(is_logged_in?).to be_falsey
  end

  it "with remembering" do
    log_in_as(user, remember_me: '1')
    expect(cookies['remember_token']).to eq assigns(:user).remember_token
  end

  it "without remembering" do
    # クッキーを保存してログイン
    log_in_as(user, remember_me: '1')
    delete logout_path
    # クッキーを削除してログイン
    log_in_as(user, remember_me: '0')
    expect(cookies['remember_token']).to be_empty
  end
end
