class TaskListsController < ApplicationController
  before_action :logged_in_user
  before_action :current_project

  def new
    @task_list = TaskList.new
  end

  def create
    @task_list = current_project.task_lists.build(task_list_params)
    if @task_list.save
      flash[:success] = "Task List created!"
      redirect_to project_task_lists_path(current_project)
    else
      render 'new'
    end
  end

  def show
    @task_list = TaskList.find(params[:id])
  end

  def index
    @task_lists = TaskList.where(project_id: params[:project_id])
  end

  def edit
    @task_list = TaskList.find(params[:id])
  end

  def update
    @task_list = TaskList.find(params[:id])

    if @task_list.update_attributes(task_list_params)
      flash[:success] = "Information Updated"
      redirect_to project_task_list_url(current_project, @task_list)
    else
      render 'edit'
    end 
  end

  def destroy
    @task_list = TaskList.find(params[:id])
    @task_list.destroy
    flash[:success] = "Task List deleted"
    redirect_to current_project
  end

  private

    def task_list_params
      params.require(:task_list).permit(:name)
    end

    def current_project
      @project = Project.find(params[:project_id])
    end

end
