class Task < ApplicationRecord
  # before_create :debug_me
  belongs_to :todo_list

  validates :title, presence: true

  # def debug_me
  #   debugger
  # end
end
