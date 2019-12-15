require 'rails_helper'

RSpec.describe "ExperimentNew", type: :request do
  let(:user) { FactoryBot.create(:user) }
  before do
    log_in_as(user)
    get new_experiment_path
  end

  it "invalid experiment information" do
    expect{
      post experiments_path, params: {experiment: { name: "",
                                                  description: "",
                                                  deadline: 1.week.after } }
    }.not_to change { Experiment.count }
    expect(response).to render_template 'experiments/new'
  end

  it "valid experiment information" do
    expect{
      post experiments_path, params: {experiment: { name: "test",
                                                  description: "",
                                                  deadline: 1.week.after } }
    }.to change { Experiment.count }.by(1)
    expect(response).to redirect_to assigns(:experiment)
  end
end
