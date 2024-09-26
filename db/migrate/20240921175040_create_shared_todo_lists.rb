class CreateSharedTodoLists < ActiveRecord::Migration[7.2]
  def change
    create_table :shared_todo_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
