class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    @todo_list = current_user.todo_lists.find(params[:todo_list_id])
    @task = @todo_list.tasks.new(task_params)
    @task.user = current_user

    if @task.save
      redirect_to todo_lists_path, notice: 'Task created!'
    else
      render 'todo_lists/show'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(completed: params[:completed] == 'true')
    redirect_to todo_lists_path, notice: 'Task updated!'
  end

  private

  def task_params
    params.require(:task).permit(:title)
  end
end
