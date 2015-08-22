require "rails_helper"
require "support/signin_helpers"
require "support/authorization_helpers"

RSpec.feature "Viewing projects" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin_user) }
  project = FactoryGirl.create(:project, name: "Sublime Text 3")

  scenario "Listing no projects" do 
    user_sign_in(user)
    visit "/"
    expect(page).to_not have_content("Sublime Text 3")
  end

  scenario "Listing all projects for admin" do 
    admin_sign_in(admin)
    visit "/"
    expect(page).to have_content("Sublime Text 3")
  end

  scenario "Listing project for user" do 
    user_sign_in(user)
    define_permission!(user, :view, project)
    visit '/'
    click_link project.name 

    expect(page.current_url).to eql(project_url(project))
  end
end