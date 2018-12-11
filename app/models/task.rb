class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :task_entries 
end
