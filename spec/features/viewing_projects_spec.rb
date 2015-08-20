require "rails_helper"
require "support/signin_helpers"
require "support/authorization_helpers"

# RSpec.feature "Viewing projects" do
#   scenario "Listing all projects" do 
#     project = FactoryGirl.create(:project, name: "Sublime Text 3")
#     visit "/"
#     click_link "Sublime Text 3"
#     expect(page.current_url).to eql(project_url(project))
#   end
# end

RSpec.feature "Viewing projects" do 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }

  before do 
    user_sign_in(user)
    define_permission!(user, :view, project)
  end

  scenario "Listing all projects" do 
    visit '/'
    click_link project.name 

    expect(page.current_url).to eql(project_url(project))
  end
end