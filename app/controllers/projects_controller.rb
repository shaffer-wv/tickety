class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = "Project created!"
      redirect_to root_url
    else
      @project_list = []
      render 'static_pages/home'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(project_params)
      flash[:success] = "Information Updated"
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:success] = "Project deleted"
    redirect_to request.referrer || root_url
  end

  private

    def project_params
      params.require(:project).permit(:title, :description)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil?
    end
end
