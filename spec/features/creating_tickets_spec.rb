require 'rails_helper'
require "support/signin_helpers"
require "support/authorization_helpers"

RSpec.feature "Creating Tickets" do 
  before do
    project = FactoryGirl.create(:project, name: "Internet Explorer")
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    define_permission!(user, "tag", project)
    define_permission!(user, "create tickets", project)
    @email = user.email 
    login_as(user)

    visit "/"
    click_link "Internet Explorer"
    click_link "New Ticket"
  end

  scenario 'with valid attributes' do 
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    within("#ticket #author") do 
      expect(page).to have_content("Created by #{@email}")
    end
  end

  scenario 'with missing fields' do 
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'with an invalid description' do 
    fill_in "Title", with: "Non-standards compliance"
    fill_in "Description", with: "123456789"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has not been created.")
    expect(page).to have_content("Description is too short")
  end

  # scenario "Creating a ticket with an attachent" do 
  #   fill_in "Title", with: "Add documentation for blink tag"
  #   fill_in "Description", with: "The blink tag has a speed attribute"

  #   attach_file "File #1", Rails.root.join("spec/fixtures/speed.txt")
  #   attach_file "File #2", Rails.root.join("spec/fixtures/spin.txt")
  #   attach_file "File #3", Rails.root.join("spec/fixtures/gradient.txt")

  #   click_button "Create Ticket"

  #   expect(page).to have_content("Ticket has been created.")

  #   within("#ticket .assets") do 
  #     expect(page).to have_content("speed.txt")
  #     expect(page).to have_content("spin.txt")
  #     expect(page).to have_content("gradient.txt")
  #   end
  # end

  scenario "Creating a ticket with tags" do 
    fill_in "Title", with: "Whatever"
    fill_in "Description", with: "More whatever"
    fill_in "ticket_tag_names", with: "browser visual"
    click_button "Create Ticket"

    expect(page).to have_content("Ticket has been created.")
    within("#ticket #tags") do 
      expect(page).to have_content("browser")
      expect(page).to have_content("visual")
    end
  end
end