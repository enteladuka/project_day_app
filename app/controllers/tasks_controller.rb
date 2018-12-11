class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:create, :show, :edit, :update, :destroy]
  before_action :find_project, only: [:create, :show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @project.tasks.create(task_params)
      if @task.save
        flash[:success] = "Task successfully created"
        redirect_to @task
      else
        render 'new'
      end
  end

  def update
      if @task.update(task_params)
        redirect_to @task
        flash[:notice] = 'Task was successfully updated.'
      else
        render 'edit'
      end
  end

  def destroy
    @task.destroy
      flash[:notice] = 'Task was successfully destroyed.'
      redirect_to tasks_url
    end
  end

  private

    def set_user
      @user = current_user
    end
    def find_project
      @project = Project.find(params[:project_id])
    end
    def set_task
      @task = Task.find(params[:id])
    end
    def task_params
      params.require(:task).permit(:task_name)
    end

end
