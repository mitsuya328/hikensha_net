require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryBot.create(:user) }

  it "should be valid" do
    expect(user).to be_valid
  end

  it "should have name" do
    user.name = " "
    expect(user).not_to be_valid
  end

  it "should have email" do
    user.email = " "
    expect(user).not_to be_valid
  end

  it "should not have too long name" do
    user.name = "a"*51
    expect(user).not_to be_valid
  end

  it "should not have too long email" do
    user.email = 'a'*244+"@example.com"
    expect(user).not_to be_valid
  end

  it "can have valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "should have unique address" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).not_to be_valid
  end

  it "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it "should have password (not blank)" do
    user.password = user.password_confirmation = " "*6
    expect(user).not_to be_valid
  end

  it "password should have a minimum length" do
    user.password = user.password_confirmation = "a"*5
    expect(user).not_to be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(user.authenticated?(:remember, '')).to be_falsey
  end
end
