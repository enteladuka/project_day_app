class Task < ApplicationRecord
  belongs_to :project
  has_many :task_entries, dependent: :destroy
  validates_associated :task_entries
  #validates_presence_of :task_entries
end
