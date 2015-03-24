require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:josh)
    @project = @user.projects.build(title: "Create a test server")
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

  test "title should be at most 140 characters" do
    @project.title = 'a' * 141
    assert_not @project.valid?
  end

  test "order should be most recent first" do
    assert_equal Project.first, projects(:most_recent)
  end
end
