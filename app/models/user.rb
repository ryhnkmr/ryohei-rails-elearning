class User < ApplicationRecord
  attr_accessor :reset_token,:remember_token
  mount_uploader :image, PictureUploader

  validates :name, presence: true,
                  length: {minimum: 3,maximum: 25}

  before_save {email.downcase!}
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                  length: {maximum: 30},
                  format: { with: EMAIL_REGEX},
                  uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: {minimum: 6}, allow_nil: true

  validates :password, presence:false, on: :facebook_login

  has_many :active_relationships, class_name:"Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following,  through: :active_relationships,
                        source: :followed
  has_many :passive_relationships, class_name:"Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers,  through: :passive_relationships,
                        source: :follower

  has_many :lessons
  has_many :categories, through: :lessons
  has_many :answers, through: :lessons
  has_many :activities
 

  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
       
  def self.search(search)
    if search 
      where(['name LIKE ?',"%#{search}%"])
    else
      all
    end
  end

  def self.from_omniauth(auth)
    user = User.where('email = ?',auth.info.email).first

    if user.blank?
      user = User.new
    end
    user.uid = auth.uid
    user.name = auth.info.name
    user.email = auth.info.email
    user.image = auth.info.image
    user.oauth_token = auth.info.image
    user.password = SecureRandom.urlsafe_base64
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest,nil)
  end

end
