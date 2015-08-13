module SigninHelpers
  def user_sign_in(user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email 
    fill_in "Password", with: "password"
    click_button "Sign in"
  end

  def admin_sign_in(user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: admin.email 
    fill_in "Password", with: "password"
    click_button "Sign in"
  end
end

RSpec.configure do |config|
  config.include SigninHelpers, :type => :feature
  config.include SigninHelpers, :type => :controller
  config.include Capybara::DSL, :type => :controller
end