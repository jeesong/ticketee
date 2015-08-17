require "rails_helper"
require "support/signin_helpers"

feature 'Deleting a user' do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }

  before do 
    admin_sign_in(admin)
    visit '/'

    click_link 'Admin'
    click_link 'Users'
  end

  scenario "Deleting a user" do 
    click_link user.email
    click_link "Delete User"

    expect(page).to have_content("User has been deleted.")
  end

  scenario "Users cannot delete themselves" do 
    click_link admin.email 
    click_link "Delete User"

    expect(page).to have_content("You cannot delete yourself!")
  end
end