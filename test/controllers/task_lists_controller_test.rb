require 'test_helper'

class TaskListsControllerTest < ActionController::TestCase

  def setup
    @project = projects(:most_recent)
    @task_list = @project.task_lists.build(name: "Build Task Lists")
  end

  test "should get new if logged in" do
    log_in_as(users(:josh))
    get :new, project_id: @project.id
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'TaskList.count' do
      post :create, task_list: { name: 'Test task list' }, project_id: @project.id
    end
    assert_redirected_to login_url
  end

end
