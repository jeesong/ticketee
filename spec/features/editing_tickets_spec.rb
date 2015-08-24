require 'rails_helper'
require "support/signin_helpers"
require "support/authorization_helpers"

RSpec.feature 'Editing Tickets' do 
  let!(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do 
    FactoryGirl.create(:ticket, project: project, author: user) 
  end
  
  before do 
    define_permission!(user, "view", project)
    define_permission!(user, "edit tickets", project)
    login_as(user)
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end 

  scenario "with valid attributes" do 
    fill_in "Title", with: "Make it really shiny!"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."

    within("#ticket h2") do 
      expect(page).to have_content("Make it really shiny!")
    end

    expect(page).to_not have_content(ticket.title)
  end 

  scenario "with invalid attributes" do 
    fill_in "Title", with: ""
    click_button "Update Ticket"

    expect(page).to have_content("Ticket has not been updated.")
  end
end