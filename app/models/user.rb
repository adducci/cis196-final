require 'bcrypt'
class User < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2 }

  has_many :matches_users, dependent: :destroy
  has_many :matches, through: :matches_users

  has_many :actors_users, dependent: :destroy
  has_many :actors, through: :actors_users

  has_many :movies_users, dependent: :destroy
  has_many :movies, through: :movies_users

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
