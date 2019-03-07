class User < ApplicationRecord

    validates :name, presence: true,
                    length: {minimum: 3,maximum: 25}

    before_save {email.downcase!}
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,
                    length: {maximum: 30},
                    format: { with: EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

    has_secure_password
    validates :password, length: {minimum: 6}
end
