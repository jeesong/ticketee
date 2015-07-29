require 'rails_helper'

RSpec.feature "Creating Projects" do 
  let!(:admin_user) { FactoryGirl.create(:admin_user) }

  before do 
    # not sure why this doesn't work
    # sign_in_as!(FactoryGirl.create(:admin_user))
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: admin_user.email
    fill_in "Password", with: "password"
    click_button "Sign in"

    click_link "New Project"
  end

  scenario "A user can create a new project" do
    fill_in "Name", with: "Sublime Text 3"
    fill_in "Description", with: "A text editor for everyone"
    click_button "Create Project"

    expect(page).to have_content("Project has been created.")

    project = Project.find_by(name: "Sublime Text 3")
    expect(page.current_url).to eql(project_url(project))

    title = "Sublime Text 3 - Projects - Ticketee"
    expect(page).to have_title(title)
  end

  scenario "A user cannot create a project without a name" do
    click_button "Create Project"

    expect(page).to have_content("Project has not been created.")
    expect(page).to have_content("Name can't be blank")
  end
end
