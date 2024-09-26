class SharedTodoListsController < ApplicationController
  before_action :set_shared_todo_list, only: [ :destroy, :show ]
  before_action :set_user_to_share_with, only: [ :create ]
  before_action :set_todo_list_to_share_with, only: [ :create ]

  def index
    @shared_todo_lists = current_user.shared_todo_lists.includes(:todo_list)
  end

  def show
  end

  def new
    @shared_todo_list = SharedTodoList.new
  end

  def create
    if @user_to_share_with
      @shared_todo_list = SharedTodoList.new(
        todo_list_id: @todo_list_to_share_with.id,
        user_id: @user_to_share_with.id
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
    @shared_todo_list = SharedTodoList.find(params[:todo_list_id])
  end

  def set_user_to_share_with
    @user_to_share_with = User.find_by(email: params[:email])
  end

  def set_todo_list_to_share_with
    @todo_list_to_share_with = TodoList.find(params[:todo_list_id])
  end

  def shared_todo_list_params
    params.require(:shared_todo_list).permit(:todo_list_id, :user_id, :email)
  end
end
