class AddProjectRefToTaskLists < ActiveRecord::Migration
  def change
    add_reference :task_lists, :project, index: true
    add_foreign_key :task_lists, :projects
  end
end
