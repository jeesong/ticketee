class TicketsController < ApplicationController
  # Tickets resource is only accessible through a project, want to have @project work with all actions 
  # in the controller
  before_action :require_signin!
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]  
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy

  def new
    # build method made available by the has_many association in model
    @ticket = @project.tickets.build
    # 3.times { @ticket.assets.build }
    @ticket.assets.build
  end

  def create
    if !current_user.admin? && cannot?(:"tag", @project)
      params[:ticket].delete(:tag_names)
    end
    
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user

    if @ticket.save 
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
    @comment = @ticket.comments.build
    @states = State.all
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@project, @ticket]
    else
      flash.now[:alert] = "Ticket has not been updated."
      render "edit"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."

    redirect_to @project
  end

  private 

  def set_project
    # project_id is made available via Rails routing
    # @project = Project.find(params[:project_id])

    # now need @project to only look for projects the user has permission seeing
    @project = Project.for(current_user).find(params[:project_id])

    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to root_path
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :tag_names, :description, assets_attributes: [:asset])
  end

  def authorize_create!
    if !current_user.admin? && cannot?("create tickets".to_sym, @project)
      flash[:alert] = "You cannot create tickets on this project."
      redirect_to @project
    end
  end

  def authorize_update!
    if !current_user.admin? && cannot?("edit tickets".to_sym, @project)
      flash[:alert] = "You cannot edit tickets on this project."
      redirect_to @project 
    end
  end

  def authorize_delete!
    if !current_user.admin? && cannot?("delete tickets".to_sym, @project)
      flash[:alert] = "You cannot delete tickets from this project."
      redirect_to @project
    end
  end
end
