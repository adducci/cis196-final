class Match < ActiveRecord::Base
  has_many :matches_movies, dependent: :destroy
  has_many :movies, through: :matches_movies

  has_many :matches_actors, dependent: :destroy
  has_many :actors, through: :matches_actors

  has_many :matches_users, dependent: :destroy
  has_many :users, through: :matches_users
end
