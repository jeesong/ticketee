require "rails_helper"
require 'support/signin_helpers'
require 'support/authorization_helpers'

feature "Assigning permissions" do 
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  before do 
    admin_sign_in(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.email 
    click_link "Permissions"
  end

  scenario "Viewing a project" do 
    check_permission_box "view", project 

    click_button "Update"
    click_link "Sign out"

    user_sign_in(user)
    expect(page).to have_content(project.name)
  end
end