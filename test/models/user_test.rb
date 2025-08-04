require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "destroying a user removes personal lists and shares" do
    user = User.create!(email: "user@example.com", password: "password")
    owner = User.create!(email: "owner@example.com", password: "password")

    personal_list = user.todo_lists.create!(name: "Personal")
    shared_list = owner.todo_lists.create!(name: "Owner list")
    SharedTodoList.create!(user: user, todo_list: shared_list)

    assert_difference("TodoList.count", -1) do
      assert_difference("SharedTodoList.count", -1) do
        user.destroy
      end
    end

    assert_not TodoList.exists?(personal_list.id)
    assert_not SharedTodoList.where(user_id: user.id).exists?
  end
end
