require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:user){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }
  let(:timetable){ FactoryBot.create(:timetable, experiment: experiment) }
  let(:subject){ timetable.subjects.new(email: "subject@example.com", experiment: experiment) }

  it "should be valid" do 
    expect(subject).to be_valid
  end

  it "timetable id  shoudl be present" do
    subject.timetable_id = nil
    expect(subject).not_to be_valid
  end

  it "email should be present" do
    subject.email = nil
    expect(subject).not_to be_valid
  end
end
