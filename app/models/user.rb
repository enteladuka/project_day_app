class User < ApplicationRecord #Inherits from ApplicationRecord/ApplicationRecord inherits from ActiveRecord::Base
  attr_accessor :remember_token
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
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # For uniqueness validation can also use validates_uniqueness_of :username, :email ?
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token #returns a random token
    SecureRandom.urlsafe_base64
  end

  def remember #remembers a user in the database for use in persistent sessions
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token) #returns true if the given token matches the digest
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget #forgets the user
    update_attribute(:remember_digest, nil)
  end

end
