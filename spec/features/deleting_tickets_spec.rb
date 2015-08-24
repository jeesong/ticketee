require 'rails_helper'
require "support/signin_helpers"
require "support/authorization_helpers"

RSpec.feature 'Deleting Tickets' do 
  let!(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do 
    FactoryGirl.create(:ticket, project: project, author: user) 
  end

  before do 
    define_permission!(user, "view", project)
    define_permission!(user, "delete tickets", project)
    login_as(user)
    visit project_ticket_path(project, ticket)
  end

  scenario "deleting successfully" do 
    click_link "Delete Ticket"

    expect(page).to have_content("Ticket has been deleted.")
    expect(page.current_url).to eq(project_url(project))
  end
end