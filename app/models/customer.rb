class Customer < ApplicationRecord
  has_many :projects
  # or has_one :projects
end
