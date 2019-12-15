require 'rails_helper'

RSpec.describe "ExperimentEdit", type: :request do
  let(:user){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }

  before do
    log_in_as(user)
    get edit_experiment_path(experiment)
  end

  it "unsuccessful edit" do   
    expect(response).to render_template 'experiments/edit'
    patch experiment_path(experiment), params: { experiment: { name: "",
                                                              description: "",
                                                              deadline: 1.week.after } }
    expect(response).to render_template 'experiments/edit'
  end

  it "successful edit" do
    name  = "Foo Bar"
    description = "foo bar baz description"
    deadline = 1.week.after
    patch experiment_path(experiment), params: { experiment: { name:  name,
                                                               description: description,
                                                               deadline: deadline } }
    expect(flash).to be_any
    expect(response).to redirect_to experiment
    experiment.reload
    expect(experiment.name).to eq name
    expect(experiment.description).to eq description
  end
end
