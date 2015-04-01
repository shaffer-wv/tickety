require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:josh)
    @project = projects(:most_recent)
  end

  test "should be valid" do
    assert @project.valid?
  end

  test "user id should be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end

  test "title should be present" do
    @project.title = nil
    assert_not @project.valid?
  end

  test "description should be present" do
    @project.description = nil
    assert_not @project.valid?
  end

  test "title should be at most 40 characters" do
    @project.title = 'a' * 141
    assert_not @project.valid?
  end

  test "description should be at most 140 characters" do
    @project.description = 'a' * 141
    assert_not @project.valid?
  end

  test "order should be most recent first" do
    assert_equal Project.first, projects(:most_recent)
  end

  test "associated task lists should be destroyed" do
    @project.save
    @project.task_lists.create!(name: "Test List")
    assert_difference 'TaskList.count', -1 do
      @project.destroy
    end
  end
end
