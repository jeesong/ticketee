require 'rails_helper'
require "support/authorization_helpers"

RSpec.describe TicketsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  context "standard users" do 
    it "cannot access a ticket for a project" do 
      sign_in(user)
      get (:show), :id => ticket.id, :project_id => project.id 

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end

    context "with permission to view the project" do 
      before do 
        sign_in(user)
        define_permission!(user, "view", project)
      end

      def cannot_create_tickets!
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql("You cannot create tickets on this project.")
      end

      def cannot_update_tickets!
        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql("You cannot edit tickets on this project.")
      end

      it "cannot begin to create a ticket" do 
        get :new, project_id: project.id 
        cannot_create_tickets!
      end

      # it "cannot create a ticket without permission" do 
      #   post :create, project_id: project.id 
      #   cannot_create_tickets!
      # end

      it "cannot edit a ticket without permission" do 
        # pass project_id so set_project can find a project
        # pass id so set_ticket can find ticket
        get :edit, { project_id: project.id, id: ticket.id }
        cannot_update_tickets!
      end

      it "cannot update a ticket without permission" do 
        # pass empty hash so params[:ticket] is set
        get :update, { project_id: project.id, id: ticket.id, ticket: {} }
        cannot_update_tickets!
      end

      it "cannot delete a ticket without permission" do 
        delete :destroy, { project_id: project.id, id: ticket.id }

        expect(response).to redirect_to(project)
        expect(flash[:alert]).to eql("You cannot delete tickets from this project.")
      end

      it "can create tickets, but not tag them" do 
        Permission.create(user: user, thing: project, action: "create tickets")
        post :create, ticket: { title: "New ticket!", description: "Brand fuckin new", tag_names: "these are tags"}, project_id: project.id

        expect(Ticket.last.tags).to be_empty
      end
    end
  end

end