class TaskEntriesController < ApplicationController
  before_action :set_task_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:new, :create]


  def index
    @task_entries = TaskEntry.where({:task_id => (params[:task_id])})
  end

  def show
  end

  def new
    @task_entry = TaskEntry.new
  end

  def edit
  end

  def create
    @task_entry = @task.task_entries.build(task_entry_params)
    if @task_entry.save!
      flash[:success] = "Task entry was successfully created."
      redirect_to task_task_entries_path
    else
      render 'new'
    end
  end

  def update
    if @task_entry.update(task_entry_params)
      flash[:success] = "Task entry was successfully updated."
      redirect_to @task_entry
    else
      render 'edit'
    end
  end

  def destroy
    @task = @task_entry.task_id
    if @task_entry.destroy
      flash[:success] = "Task entry was deleted."
      redirect_to task_task_entries_path(@task)
    else
      flash[:danger] = "Task entry could not be deleted."
      redirect_to @task
    end
  end

  private

    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_task_entry
      @task_entry = TaskEntry.find(params[:id])
    end

    def task_entry_params
      params.require(:task_entry).permit(:note)
    end
end
