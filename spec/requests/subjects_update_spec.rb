require 'rails_helper'

RSpec.describe "SubjectsUpdate", type: :request do
  let(:user){ FactoryBot.create(:user) }
  let(:examiner){ FactoryBot.create(:user) }
  let(:experiment){ FactoryBot.create(:experiment, user: examiner) }
  let(:timetable){ FactoryBot.create(:timetable, experiment: experiment, number_of_subjects: 1) }
  let(:other_timetable){ FactoryBot.create(:timetable, experiment: experiment)}
  let(:subject){ FactoryBot.create(:subject, experiment: experiment, timetable: timetable, user: user) }

  describe "correct user" do
    before do
      log_in_as user
      get edit_subject_path(subject)
    end

    it "successful edit" do
      patch subject_path(subject), params: { subject: { timetable: timetable,
                                                        email: "subject2@example.com",
                                                        sex: '1',
                                                        birth_date: "2000-1-1" } }
    end
  end

end
