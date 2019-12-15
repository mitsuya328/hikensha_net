require 'rails_helper'

RSpec.describe "Experiments", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, email: "archer@example.com") }
  let!(:experiment) { FactoryBot.create(:experiment, user: user) }

  it "should redirect create when not logged in" do
    expect{
      post experiments_path, params: { experiment: { name: "実験" } }
    }.not_to change{ Experiment.count }
    expect(response).to redirect_to login_path
  end

  it "should redirect destroy when not logged in" do
    expect{
      delete experiment_path(experiment)
    }.not_to change{ Experiment.count }
    expect(response).to redirect_to login_path
  end

  it "should redirect destroy when not logged in" do
    log_in_as(other_user)
    expect{
      delete experiment_path(experiment)
    }.not_to change{ Experiment.count }
    expect(response).to redirect_to root_path
  end
end
