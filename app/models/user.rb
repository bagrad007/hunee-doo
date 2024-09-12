class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :todo_lists
  has_many :tasks, through: :todo_lists
end
