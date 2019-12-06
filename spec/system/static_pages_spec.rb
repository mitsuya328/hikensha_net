require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  it "should get home" do
    visit root_path
    expect(page).to have_title "Home"
  end

  it "should get help" do
    visit static_pages_help_path
    expect(page).to have_title "Help"
  end

  it "should get about" do
    visit static_pages_about_path
    expect(page).to have_title "About"
  end
end
