class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @project = current_user.projects.build
      @project_list = current_user.project_list.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
