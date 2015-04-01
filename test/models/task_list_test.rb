require 'test_helper'

class TaskListTest < ActiveSupport::TestCase

  def setup
    @project = projects(:most_recent)
    @task_list = @project.task_lists.build(name: "Build Task Lists")
    # @task_list = TaskList.new(name: "Build Task Lists", 
    #   completed: false, project_id: 1)
  end
  
  test "should be valid" do
    assert @task_list.valid?
  end

  test "name should be present" do
    @task_list.name = ""
    assert_not @task_list.valid?
  end

  test "name should not be too long" do
    @task_list.name = 'a' * 141
    assert_not @task_list.valid?
  end

  test "project id should be present" do
    @task_list.project_id = nil
    assert_not @task_list.valid?
  end
end
