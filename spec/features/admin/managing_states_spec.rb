require 'rails_helper'
require 'support/signin_helpers'
require 'support/capybara_helpers'

feature "Managing states" do 
  let(:admin) { FactoryGirl.create(:admin_user) }

  before do 
    load Rails.root + "db/seeds.rb"
    admin_sign_in(admin)
  end

  scenario "Marking a state as default" do 
    visit "/"
    click_link "Admin"
    click_link "States"
    within state_line_for("New") do 
      click_link "Make Default"
    end

    expect(page).to have_content("New is now the default state.")
  end
end