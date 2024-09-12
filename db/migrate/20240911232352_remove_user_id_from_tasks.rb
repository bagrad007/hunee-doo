class RemoveUserIdFromTasks < ActiveRecord::Migration[7.2]
  def change
    remove_column :tasks, :user_id
  end
end
