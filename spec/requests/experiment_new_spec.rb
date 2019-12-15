require 'rails_helper'

RSpec.describe "ExperimentNew", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/rails.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

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
    picture = 
    expect{
      post experiments_path, params: {experiment: { name: "test",
                                                  description: "",
                                                  deadline: 1.week.after,
                                                  picture: image } }
    }.to change { Experiment.count }.by(1)
    expect(response).to redirect_to assigns(:experiment)
  end
end
