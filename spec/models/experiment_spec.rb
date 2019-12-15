require 'rails_helper'

RSpec.describe Experiment, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:experiment) { user.experiments.build(name: "experiment", description: "model test") }

  it "should be valid" do
    expect(experiment).to be_valid
  end

  it "user id should be present" do
    experiment.user_id = nil
    expect(experiment).not_to be_valid
  end

  it "name should be present" do
    experiment.name = " "
    expect(experiment).not_to be_valid
  end

  it "name should be at most 255 characters" do
    experiment.name = "a" *256
    expect(experiment).not_to be_valid
  end
end
