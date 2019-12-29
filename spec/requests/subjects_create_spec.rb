require 'rails_helper'

RSpec.describe "SubjectsCreate", type: :request do
  let(:user){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }
  let(:timetable){ FactoryBot.create(:timetable, experiment: experiment) }

  it "invalid subject information" do
    get new_experiment_subject_path(experiment)
    expect{
      post experiment_subjects_path(experiment), params: { subject: { email: "",
                                                          sex: '1',
                                                          birth_date: 20.year.ago,
                                                          timetable_id: timetable.id } }
    }.not_to change { Subject.count }
    expect(response).to render_template 'subjects/new'
  end

  it "valid subject information" do
    get new_experiment_subject_path(experiment)
    expect{
      post experiment_subjects_path(experiment), params: { subject: { email: "subject@example.com",
                                                          sex: '1',
                                                          birth_date: 20.year.ago,
                                                          timetable_id: timetable.id } }
    }.to change { Subject.count }.by(1)
    expect(response).to redirect_to experiment
  end

  describe "when logged in as experimenter" do
    before{ log_in_as(user) }

    it "should redirect new" do
      get new_experiment_subject_path(experiment)
      expect(response).to redirect_to experiment_path(experiment)
    end

    it "should redirect create" do
      post experiment_subjects_path(experiment), params: { subject: { email: "subject@example.com",
                                                                      sex: '1',
                                                                      birth_date: 20.year.ago,
                                                                      timetable_id: timetable.id } }
      expect(response).to redirect_to experiment_path(experiment)
    end
  end
end
