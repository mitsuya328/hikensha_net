require 'rails_helper'

RSpec.describe "UsersEdit", type: :request do
  let(:user){ FactoryBot.create(:user) }

  it "unsuccessful edit" do
    log_in_as(user)
    get edit_user_path(user)
    expect(response).to render_template 'users/edit'    
    patch user_path(user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    expect(response).to render_template 'users/edit'
  end

  it "successful edit with friendly forwarding" do
    get edit_user_path(user)
    log_in_as(user)
    expect(response).to redirect_to edit_user_path(user)
    expect(session[:forwarding_url]).to be_nil
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    expect(flash).to be_any
    expect(response).to redirect_to user
    user.reload
    expect(user.name).to eq name
    expect(user.email).to eq email
  end
end
