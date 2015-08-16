class ProjectsController < ApplicationController
  # before_action :require_signin!, except: [:index, :show]
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project 
    else
      flash.now[:alert] = "Project has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project has been deleted."

    redirect_to projects_path
  end

  private

  def project_params
    # params[:project] has all the data we need to pass to Project.new/Project.update
    # params provided to controller, available to all Rails controller actions
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."

      redirect_to projects_path
  end

  # move this to application controller
  # def authorize_admin!
  #   require_signin!

  #   unless current_user.admin?
  #     flash[:alert] = "You must be an admin to do that."
  #     redirect_to root_path
  #   end
  # end
end
