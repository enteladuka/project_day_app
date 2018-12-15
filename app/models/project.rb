class Project < ApplicationRecord
  belongs_to :customer
  has_many :tasks, dependent: :destroy
  validates_associated :tasks
  #validates_presence_of :tasks
end
