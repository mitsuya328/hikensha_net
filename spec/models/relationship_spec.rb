require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:examiner) { FactoryBot.create(:user)}
  let(:examinee) { FactoryBot.create(:user) }
  let(:relationship) { Relationship.new(examiner_id: examiner.id, examinee_id: examinee.id)}

  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require a examiner_id" do
    relationship.examiner_id = nil
    expect(relationship).not_to be_valid
  end

  it "should require a examinee_id" do
    relationship.examinee_id = nil
    expect(relationship).not_to be_valid
  end

end
