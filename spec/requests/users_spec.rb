require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: "archer@example.com") }

  it "should get new" do
    get signup_path
    expect(response).to have_http_status(:success)
  end

  describe "when not logged in" do
    it "should redirect edit when not logged in" do
      get edit_user_path(user)
      expect(flash).to be_any
      expect(response).to redirect_to login_path
    end

    it "should redirect update when not logged in" do
      patch user_path(user), params: {user: { name: user.name,
                                              email: user.email } }
      expect(flash).to be_any
      expect(response).to redirect_to login_path
    end
  end

  describe "when logged in wrong user" do
    before { log_in_as(other_user) }

    it "should redirect edit" do
      get edit_user_path(user)
      expect(flash).to be_empty
      expect(response).to redirect_to root_path
    end

    it "should redirect update" do
      patch user_path(user), params: {user: { name: user.name,
                                              email: user.email } }
      expect(flash).to be_empty
      expect(response).to redirect_to root_path
    end
  end
end
