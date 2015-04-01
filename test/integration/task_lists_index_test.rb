require 'test_helper'

class TaskListsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:josh)
    @project = projects(:most_recent)
    @task_list = task_lists(:one)
  end

  test "index" do
    log_in_as(@user)
    get project_task_lists_path(@project)
    assert_template 'task_lists/index'
    assert_select 'h1', text: @project.title
    # task_list is not part of this project so
    # it doesn't show up in this index page
    # assert_match @task_list.name, response.body
  end
end
