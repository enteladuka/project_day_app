class User < ApplicationRecord

  attr_accessor :remember_token, :activation_token, :reset_token

  has_secure_password

  has_many :tasks

  #VALID_USERNAME_REGEX = /\A\w\z/i # Proof: http://rubular.com/r/WplaODtchP.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { self.email = email.downcase } # self is the current user
  before_save { self.username = username.downcase }

  before_create :create_activation_digest

  enum role: [:admin, :standard]

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end

  validates :username, presence: true, length: { in: 4..30 },
                       #format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }

  validates :email, presence: true , length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true


  # def downcase_attributes(attrs = [])
  #   attrs.each(&:downcase)
  # end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget #forgets the user
    update_attribute(:remember_digest, nil)
  end

  def activate #activates an account
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email #sends activation email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest #sets password reset attributes
    self.reset_token = new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired? #returns true if password expired
    reset_sent_at < 2.hours.ago
  end

  private

  def create_activation_digest #creates and assigns the activation token and digest
    self.activation_token = new_token
    self.activation_digest = User.digest(activation_token)
  end

end
