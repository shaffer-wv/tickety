require 'test_helper'

class TaskListsCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @project = projects(:most_recent)
  end

  test "should be invalid without a name" do
    log_in_as(@user)
    get new_project_task_list_path(@project)
    assert_no_difference 'TaskList.count' do
      post project_task_lists_path, task_list: 
        { name: ' ' }, project_id: @project.id
    end
    assert_template 'task_lists/new'
  end
  
  test "create with valid information" do
    log_in_as(@user)
    get new_project_task_list_path(@project)
    assert_difference 'TaskList.count', 1 do
      post project_task_lists_path, task_list: 
        { name: 'Test Task List' }, project_id: @project.id
    end
    assert_redirected_to project_task_lists_path(@project)
  end
end
