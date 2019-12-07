require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "should get new" do
    get signup_path
    expect(response).to have_http_status(:success)
  end
end
