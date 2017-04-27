class Movie < ActiveRecord::Base
  validates :title, :tmdb_id, presence: true
  validates :title, :tmdb_id, length: { minimum: 1 }
  validates_uniqueness_of :tmdb_id

  has_many :movies_actors, dependent: :destroy
  has_many :actors, through: :movies_actors

  has_many :matches_movies, dependent: :destroy
  has_many :matches, through: :matches_movies

  has_many :movies_users, dependent: :destroy
  has_many :users, through: :movies_users
end
