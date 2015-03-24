require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  
  def setup
    @project = projects(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Project.count' do
      post :create, project: { title: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Project.count' do
      delete :destroy, id: @project
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong project" do
    log_in_as(users(:josh))
    project = projects(:six)
    assert_no_difference 'Project.count' do
      delete :destroy, id: project
    end
    assert_redirected_to root_url
  end
  
end
