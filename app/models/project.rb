class Project < ApplicationRecord
  belongs_to :customer
  has_many :tasks, dependent: :destroy
  validates_associated :customer
  #validates_presence_of :tasks
end
