class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:create, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = @customer.projects.create(project_params)
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        redirect_to project_path(@project)
      else
         render 'new'
      end
    end
  end

  def update
      if @project.update(project_params)
        flash[:notice] = 'Project was successfully updated'
        redirect_to project_path(@project)
      else
        render 'edit'
      end
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = 'Project was successfully destroyed'
    redirect_to projects_path
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:project_name)
    end
end
