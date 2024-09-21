class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :todo_lists
  has_many :tasks, through: :todo_lists


  has_many :shared_todo_lists
  has_many :shared_todos, through: :shared_todo_lists, source: :todo_list
  has_many :shared_tasks, through: :shared_todos, source: :tasks
end
