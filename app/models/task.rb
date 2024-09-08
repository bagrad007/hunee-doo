class Task < ApplicationRecord
  belongs_to :todo_list
  belongs_to :user

  validates :title, presence: true
end
