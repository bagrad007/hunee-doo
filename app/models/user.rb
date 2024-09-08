class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :todo_lists
  has_many :tasks
  has_many :shared_tasks, through: :todo_lists, source: :tasks
end
