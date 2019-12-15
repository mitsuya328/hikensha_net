require 'rails_helper'

RSpec.describe "ExperimentDestroy", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:experiment) { FactoryBot.create(:experiment, user: user) }

  it "delete when logged in as a correct user" do
    log_in_as(user)
    expect{
      delete experiment_path(experiment)
    }.to change{ Experiment.count }.by(-1)
  end
end
