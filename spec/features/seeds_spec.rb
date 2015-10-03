require 'rails_helper'
require 'support/signin_helpers'
require 'support/authorization_helpers'

feature "Seed Data" do 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  before do 
    define_permission!(user, "view", project)
    define_permission!(user, "create tickets", project)
    define_permission!(user, "change states", project)

    login_as(user)
    visit '/'
    click_link project.name
  end

  scenario "The basics" do 
    load Rails.root + "db/seeds.rb"
    # user = User.where(email: "admin@example.com").first!
    # user.password = "password"
    # project = Project.where(name: "Ticketee Beta").first!
    
    click_link "New Ticket"
    fill_in "Title", with: "Comments with state"
    fill_in "Description", with: "Comments always have a state."
    click_button "Create Ticket"

    within("#comment_state_id") do 
      expect(page).to have_content("New")
      expect(page).to have_content("Open")
      expect(page).to have_content("Closed")      
    end   
  end
end