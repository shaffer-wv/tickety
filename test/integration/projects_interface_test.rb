require 'test_helper'

class ProjectsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:josh)
  end

  test "project interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Project.count' do
      post projects_path, project: { title: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    title = "Test Project"
    description = "This is a test project title"
    assert_difference 'Project.count', 1 do
      post projects_path, project: { title: title, description: description }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_project = @user.projects.paginate(page: 1).first
    assert_difference 'Project.count', -1 do
      delete project_path(first_project)
    end
    # Visit a different user.
    get user_path(users(:sam))
    assert_select 'a', text: 'delete', count: 0
  end
end
