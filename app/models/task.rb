class Task < ApplicationRecord
  attr_accessor :tasks
  belongs_to :project
  has_many :task_entries
end
