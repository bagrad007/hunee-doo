class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [ :new, :create ]
  before_action :set_task, only: [ :show, :update, :edit, :destroy ]

  def index
    if current_user
      @tasks = current_user.tasks
    end
  end

  def new
    @task = @todo_list.tasks.new
  end

  def show
  end

  def edit
    # binding.pry
  end

  def create
    @task = @todo_list.tasks.new(todo_list_id: @todo_list.id, title: task_params[:title], completed: task_params[:completed])

    if @task.save
      redirect_to todo_list_path(@todo_list), notice: "Task created!"
    else
      @tasks = @todo_list.tasks
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to todo_list_path(@task.todo_list_id), notice: "Task updated!"
    else
      redirect_to todo_list_path(@task.todo_list_id), alert: "Task update failed!"
    end
  end

  def destroy
    @task.destroy
    redirect_to todo_list_path(@task.todo_list_id), notice: "Task deleted!"
  end

  private

  def set_todo_list
    @todo_list = TodoList.find_by(id: params[:todo_list_id]) || TodoList.find_by(id: task_params[:todo_list_id])
  end

  def set_task
    @task = Task.find(params[:id]) || Task.find(task_params["id"])
  end

  def task_params
    params.require(:task).permit(:title, :completed, :todo_list_id)
  end
end
