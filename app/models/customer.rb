class Customer < ApplicationRecord
  #before_destroy :no_referenced_projects
  has_many :projects, dependent: :destroy
  # validates_associated :projects
  # validates_presence_of :projects
  # valid? will be called upon each one of the associated objects.

  VALID_ADDRESS_REGEX = /[A-Za-z0-9'\.\-\s\#\,]/i #Proof http://rubular.com/r/zQpaTNvat0
  VALID_CITY_REGEX = /\A\p{Lu}\p{L}*(?:[\s-]\p{Lu}\p{L}*)*$\z/i #Proof http://rubular.com/r/T2dEeA2dHW
  VALID_ZIP_REGEX = /\A^[0-9]{5}(?:-[0-9]{4})?$\z/ #Proof http://rubular.com/r/MCHew0b8KT
  #for valid zip regex, rails has a helper numericality to ensure that it only has integers, however this checks for both 5 and 9 digit zips

  validates :company, :address, :city, :state, :zip, :company, presence: true

  validates :address, length: { maximum: 100 },
                      format: { with: VALID_ADDRESS_REGEX, message: "cannot contain special characters '!@$%^&*()'"}

  validates :city, format: { with: VALID_CITY_REGEX, message: "invalid entry"}

  validates :zip, format: { with: VALID_ZIP_REGEX, message: "zip must match format '12345' or '12345-6789'"}

#Remember - want to add validation for company uniqueness that checks to see if the address is already taken?

#There are other ways to validate data before it is saved to database,
# including native database constraints, client-side validations, and controller-level validations.
# Database constraints - make validation mechanisms database-dependent and can make testing and maintenance difficult.
# however if the database was used by other applications, then it would be good to use constraints at the database level
# Client side validations - generally unreliable - if they are implmeneted using javascript, they can be bypassed if javascript is turned off in the browser.
# Controller level validations can be difficult to test and maintain


#This doesnt work yet 
# private
#
#   def no_referenced_projects
#     return if projects.empty?
#     self.errors.add(:base, "This customer is referenced by project(s)")
#     false
#   end
#
end
