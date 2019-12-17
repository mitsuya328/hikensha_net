require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:user){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }
  let(:subject){ experiment.subjects.build(start_at: 1.week.after)}
  it "should be valid" do 
    expect(subject).to be_valid
  end

  #it "experiment id  shoudl be present" do
  #  subject.experiment_id = nil
  #  expect(subject).not_to be_valid
  #end

  it "start_at should be present" do
    subject.start_at = nil
    expect(subject).not_to be_valid
  end

  describe "subject associations" do
    let!(:later_subject) do
      FactoryBot.create(:subject, experiment: experiment, start_at: 1.week.after)
    end
    let!(:earlier_subject) do
      FactoryBot.create(:subject, experiment: experiment, start_at: 1.day.after)
    end

    it "should have the right subjects in the right order" do
      expect(experiment.subjects.to_a).to eq [earlier_subject, later_subject]
    end
  end
end
