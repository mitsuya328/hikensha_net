require 'rails_helper'

RSpec.describe Timetable, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: user) }
  let(:timetabele){ experiment.timetables.new(start_at: 1.day.after) }

  it "should be valid" do
    expect(timetabele).to be_valid
  end

  #it "experiment id should be present" do
  #  timetabele.experiment_id = nil
  #  expect(timetabele).not_to be_valid
  #end

  #it "start_at should be present" do
  #  timetabele.start_at = nil
  #  expect(timetabele).not_to be_valid
  #end
end
