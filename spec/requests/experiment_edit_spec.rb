require 'rails_helper'

RSpec.describe "ExperimentEdit", type: :request do
  let(:user){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }

  it "unsuccessful edit" do
    log_in_as(user)
    get edit_experiment_path(experiment)
    expect(response).to render_template 'experiments/edit'
    patch experiment_path(experiment), params: { experiment: { name: "",
                                                              description: "",
                                                              deadline: 1.week.after } }
    expect(response).to render_template 'experiments/edit'
  end
end
