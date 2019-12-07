require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it "full title helper" do
    expect(full_title).to eq "被験者ネット"
    expect(full_title("Hoge")).to eq "Hoge | 被験者ネット"
  end
end
