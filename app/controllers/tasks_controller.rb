class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [ :new, :create ]
  before_action :set_task, only: [ :show, :update, :edit, :destroy ]

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = @todo_list.tasks.new
  end

  def show
  end

  def create
    @task = @todo_list.tasks.new(todo_list_id: @todo_list.id, title: task_params[:title], completed: task_params[:completed])

    if @task.save
      redirect_to tasks_path, notice: "Task created!"
    else
      @tasks = @todo_list.tasks
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated!"
    else
      redirect_to tasks_path, alert: "Task update failed!"
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_todo_list
    # binding.pry
    @todo_list = current_user.todo_lists.find(task_params["todo_list_id"])
  end

  def set_task
    @task = Task.find(task_params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :todo_list_id)
  end
end
