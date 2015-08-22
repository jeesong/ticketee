require "rails_helper"
require "support/signin_helpers"

RSpec.feature 'Deleting Projects' do 
  let(:admin) { FactoryGirl.create(:admin_user) }

  before do 
    admin_sign_in(admin)
  end

  scenario "Deleting a project" do 
    FactoryGirl.create(:project, name: "Fall Coding Project")

    visit "/"
    click_link "Fall Coding Project"
    click_link "Delete Project"

    expect(page).to have_content("Project has been deleted.")

    visit "/"

    expect(page).to have_no_content("Fall Coding Project")
  end
end