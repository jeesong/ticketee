require "rails_helper"
require "support/signin_helpers"

RSpec.feature 'Deleting Projects' do 
  let(:admin) { FactoryGirl.create(:admin_user) }

  before do 
    admin_sign_in(admin)
  end

  scenario "Deleting a project" do 
    FactoryGirl.create(:project, name: "Sublime Text 3")

    visit "/"
    click_link "Sublime Text 3"
    click_link "Delete Project"

    expect(page).to have_content("Project has been deleted.")

    visit "/"

    expect(page).to have_no_content("Sublime Text 3")
  end
end