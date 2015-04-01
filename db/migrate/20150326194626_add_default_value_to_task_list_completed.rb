class AddDefaultValueToTaskListCompleted < ActiveRecord::Migration
  def change
    change_column_default :task_lists, :completed, false
  end
end
