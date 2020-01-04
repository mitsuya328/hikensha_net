require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  it "should get home and have layout links" do
    visit root_path
    expect(page).to have_title full_title
    expect(page).to have_link href: root_path, count: 2
    expect(page).to have_link href: help_path
    expect(page).to have_link href: about_path
    expect(page).to have_link href: contact_path
    expect(page).to have_link href: news_path
  end

  it "should get help" do
    visit help_path
    expect(page).to have_title full_title("Help")
  end

  it "should get about" do
    visit about_path
    expect(page).to have_title full_title("被験者ネットについて")
  end

  it "should get contact" do
    visit contact_path
    expect(page).to have_title full_title("Contact")
  end

  it "should get news" do
    visit news_path
    expect(page).to have_title full_title("News")
  end
end
