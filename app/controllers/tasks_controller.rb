class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [:new, :create]
  before_action :set_task, only: [:show, :update, :edit, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = @todo_list.tasks.new
  end

  def show
  end

  def create
    @task = @todo_list.tasks.new(task_params)

    if @task.save
      redirect_to todo_lists_path, notice: "Task created!"
    else
      @tasks = @todo_list.tasks
      render "todo_lists/show"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to todo_lists_path, notice: "Task updated!"
    else
      redirect_to todo_lists_path, alert: "Task update failed!"
    end
  end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_lists_path, alert: "Todo list not found."
  end

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_lists_path, alert: "Task not found."
  end

  def task_params
    params.require(:task).permit(:title, :completed, :todo_list_id)
  end
end
