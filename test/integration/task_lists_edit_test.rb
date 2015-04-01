require 'test_helper'

class TaskListsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @project = projects(:most_recent)
    @task_list = task_lists(:one)
  end

  test "invalid edit information" do
    log_in_as(@user)
    get edit_project_task_list_path(@project, @task_list)
    assert_template 'task_lists/edit'
    patch project_task_list_path(@project, @task_list), task_list: { name: "" }
    assert_template 'task_lists/edit'
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_project_task_list_path(@project, @task_list)
    assert_template 'task_lists/edit'
    patch project_task_list_path(@project, @task_list), task_list: { name: "Test" }
    assert_not flash.empty?
    assert_redirected_to project_task_list_path(@project, @task_list)
    @task_list.reload
    assert_equal @task_list.name, "Test"
  end

end
