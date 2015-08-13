require 'rails_helper'
require 'support/signin_helpers'

RSpec.describe Admin::UsersController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }

  context "standard users" do 
    before do 
      user_sign_in(user)
    end

    it "are not able to access the index action" do 
      get 'index'
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql("You must be an admin to do that.")
    end
  end

  # describe "GET index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
