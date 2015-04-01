require 'test_helper'

class TaskListsShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:josh)
    @project = projects(:most_recent)
    @task_list = task_lists(:one)
  end

  test "task list display" do
    log_in_as(@user)
    get project_task_list_path(@project, @task_list)
    assert_select 'h1', text: @project.title
    assert_match @task_list.name, response.body
  end

end
