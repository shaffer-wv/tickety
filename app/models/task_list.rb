class TaskList < ActiveRecord::Base
  belongs_to :project
  validates :name, presence: true, length: { maximum: 140 }
  validates :project_id, presence: true


  private

    def get_task_lists(project)
      self.find_by(project_id: project.id)
    end
end
