class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  #before_action :find_project, only: [:create, :show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]

  def index
    @tasks = Task.where({:project_id =>(params[:project_id])})
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    :user_id == current_user.id
    @task = @project.tasks.build(task_params)
    if @task.save!
      #assign_user
      flash[:success] = "Task created!"
      redirect_to project_tasks_path
    else
      render 'new'
    end
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task was successfully updated.'
      redirect_to @task
    else
      render 'edit'
    end
  end

  def destroy
    @project = @task.project_id
    @task.destroy
      flash[:success] = 'Task was successfully destroyed.'
      redirect_to project_tasks_path(@project)
  end

  private

    def task_params
      params.require(:task).permit(:task_name, :user_id)
    end

    # def assign_user
    #   @task.update_attributes(:user_id => current_user.id)
    # end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

end
