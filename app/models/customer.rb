class Customer < ApplicationRecord
#before_destroy :no_referenced_projects
has_many :projects, dependent: :destroy
validates_associated :projects
# validates_presence_of :projects
# valid? will be called upon each one of the associated objects.





# private
#
#   def no_referenced_projects
#     return if projects.empty?
#     self.errors.add(:base, "This customer is referenced by project(s)")
#     false
#   end
#
end
