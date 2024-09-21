class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  has_many :shared_todo_lists
  has_many :shared_users, through: :shared_todo_lists, source: :user

  validates :name, presence: true
end
