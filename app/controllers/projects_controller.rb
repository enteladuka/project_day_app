class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :create]

  def index
    @projects = Project.where({:customer_id =>(params[:customer_id])})
  end

  def new
    @project = Project.new
  end

  def create
    @project = @customer.projects.build(project_params)
    if @project.save!
      flash[:success] = "Project created!"
      redirect_to customer_projects_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = "Project successfully updated!"
      redirect_to project_path
    else
      render 'edit'
    end
  end

  def destroy
    @customer = @project.customer_id
    @project.destroy
    flash[:success] = 'Project was successfully destroyed'
    redirect_to customer_projects_path(@customer)
    end
  end

  private


    def project_params
      params.require(:project).permit(:project_name)
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def set_project
      @project = Project.find(params[:id])
    end
