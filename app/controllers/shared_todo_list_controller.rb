class SharedTodoListController < ApplicationController
  before_action :set_shared_todo_list, only: [ :destroy, :create, :show ]

  def index
    @shared_todo_lists = current_user.shared_todo_lists.includes(:todo_list)
  end

  def show
  end

  def create
    user_to_share_with = User.find_by(email: params[:email])

    if user_to_share_with
      @shared_todo_list = SharedTodoList.new(
        todo_list_id: params[:todo_list_id],
        user_id: user_to_share_with.id
      )
      if @shared_todo_list.save
        redirect_to todo_list_path(params[:todo_list_id]), notice: "Todo list was successfully shared."
      else
        redirect_to todo_list_path(params[:todo_list_id]), alert: "Failed to share the todo list."
      end
    else
      redirect_to todo_list_path(params[:todo_list_id]), alert: "User not found."
    end
  end

  def destroy
    @shared_todo_list.destroy
    redirect_to todo_list_path(@shared_todo_list.todo_list), notice: "Todo list was successfully unshared."
  end

  private

  def set_shared_todo_list
    @shared_todo_list = SharedTodoList.find(params[:id])
  end

  def shared_todo_list_params
    params.require(:shared_todo_list).permit(:todo_list_id, :user_id)
  end
end
