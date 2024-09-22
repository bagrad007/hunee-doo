class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [ :show, :edit, :update, :destroy ]

  def index
    @todo_lists = current_user.todo_lists
  end
  def show
    @tasks = @todo_list.tasks
  end

  def edit
  end

  def new
    @todo_list = current_user.todo_lists.new
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    if @todo_list.save
      redirect_to todo_lists_path, notice: "Todo list was successfully created."
    else
      render :new
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to @todo_list, notice: "Todo list was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @todo_list.destroy
    redirect_to todo_lists_url, notice: "Todo list was successfully destroyed."
  end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  end

  def set_shared_todo_list
    if @todo_list
      @shared_todo_list = @todo_list.shared_todo_lists.find(params[:id])
    end
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :user_id)
  end
end
