class User < ApplicationRecord #Inherits from ApplicationRecord/ApplicationRecord inherits from ActiveRecord::Base
  before_save { self.email = email.downcase } #self is the current user
  before_save { self.username = username.downcase }
  VALID_USERNAME_REJEX = /\A[a-z0-9_]{4,30}\z/i
  validates :username, presence: true, length: { maximum: 30 }, #do not need length validation here but included anyway
                       format: { with: VALID_USERNAME_REJEX },
                       uniqueness: { case_sensitive: false }
                       #validates the presence of username attribute ( .blank? -> generates error ["Name can't be blank"] )

  VALID_EMAIL_REJEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true , length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REJEX },
                    uniqueness: { case_sensitive: false } #rails infers uniquess should be true
  validates :password, presence: true, length: { minimum: 8 }

  # For uniqueness validation can also use validates_uniqueness_of :username, :email ?
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
