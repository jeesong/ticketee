class TicketsController < ApplicationController
  # Tickets resource is only accessible through a project, want to have @project work with all actions 
  # in the controller
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)

    if @ticket.save 
      flash[:notice] = "Ticket has been created."
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
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
    @project = Project.find(params[:project_id])
  end

  def set_ticket
    @ticket = @project.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:title, :description)
  end
end
