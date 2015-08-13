require "rails_helper"
require "support/signin_helpers"

RSpec.feature "Editing Projects" do 
  let(:admin) { FactoryGirl.create(:admin_user) }

  # help set up state for multiple tests, block runs before each test executes
  before do 
    admin_sign_in(admin)
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "Updating a project" do 
    fill_in "Name", with: "Sublime Text 3 beta"
    click_button "Update Project"

    expect(page).to have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project has not been updated.")
  end
end