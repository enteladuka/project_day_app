class TaskEntriesController < ApplicationController
  before_action :set_task
  before_action :set_task_entry, only: [:show, :edit, :update, :destroy]

  def index
    @task_entries = TaskEntry.all
  end

  def show
  end

  def new
    @task_entry = TaskEntry.new
  end

  def edit
  end

  def create
    @task_entry = @task.task_entries.create(task_entry_params)
    if @task_entry.save
      flash[:success] = "Task entry was successfully created."
      redirect_to @task
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
    @task_entry = @task.task_entries.find(params[:id])
    if @task_entry.destroy
      flash[:success] = "Task entry was deleted."
    else
      flash[:error] = "Task entry could not be deleted."
    end
    redirect_to @task
  end

  # def duration
  #   duration = (Time.now - task_item.created_at).to_i
  #   @task_item.update_attribute(:duration, duration)
  #   flash[:success] = "Task entry completed."
  # end

  private

    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_task_entry
      @task_entry = @task.task_entries.find(params[:id])
    end

    def task_entry_params
      params.require(:task_entry).permit(:note)
    end
end
