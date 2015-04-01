class Project < ActiveRecord::Base
  belongs_to :user
  has_many :task_lists, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 140 }
end
