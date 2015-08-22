require "rails_helper"
require "support/signin_helpers"

RSpec.feature "Editing Projects" do 
  let(:admin) { FactoryGirl.create(:admin_user) }

  # help set up state for multiple tests, block runs before each test executes
  before do 
    admin_sign_in(admin)
    FactoryGirl.create(:project, name: "Fall Coding Project")

    visit "/"
    click_link "Fall Coding Project"
    click_link "Edit Project"
  end

  scenario "Updating a project" do 
    fill_in "Name", with: "Fall Coding Project beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end
end