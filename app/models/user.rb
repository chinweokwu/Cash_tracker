class User < ApplicationRecord
    EMAIL_FORMAT_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, format: { with: EMAIL_FORMAT_REGEX }, uniqueness: true
end
