require 'rails_helper'
require "support/signin_helpers"
require "support/authorization_helpers"

RSpec.feature "Creating Tickets" do 
  before do
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    @email = user.email 
    login_as(user)

    visit "/"
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario 'with valid attributes' do 
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    within("#ticket #author") do 
      expect(page).to have_content("Created by #{@email}")
    end
  end

  scenario 'with missing fields' do 
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'with an invalid description' do 
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "123456789"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end
end