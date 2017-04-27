require 'open-uri'
class Actor < ActiveRecord::Base
  validates :name, :tmdb_id, presence: true
  validates :name, :tmdb_id, length: { minimum: 1 }
  validates_uniqueness_of :tmdb_id

  has_many :movies_actors, dependent: :destroy
  has_many :movies, through: :movies_actors

  has_many :matches_actors, dependent: :destroy
  has_many :matches, through: :matches_actors

  has_many :actors_users, dependent: :destroy
  has_many :users, through: :actors_users

  def valid_name?
     name != nil && name != ""
  end

  def query_format
    CGI.escape(name.split(' ').join('+'))
  end

  def in_database?
    query = query_format
    url = "https://api.themoviedb.org/3/search/person?api_key=508ee1ec4aaf5c5bc0654504214df6f1&language=en-US&page=1&include_adult=false&query=#{query}"
    hash = JSON.parse(open(url).read)
    return hash['total_results'] > 0 && hash['results'][0]['name'].downcase == name.downcase
  end

  def reset_name
    query = query_format
    url = "https://api.themoviedb.org/3/search/person?api_key=508ee1ec4aaf5c5bc0654504214df6f1&language=en-US&page=1&include_adult=false&query=#{query}"
    hash = JSON.parse(open(url).read)
    self.name = hash['results'][0]['name'] if hash['total_results'] > 0
  end

  def find_tmdb_id
  	query = query_format
    url = "https://api.themoviedb.org/3/search/person?api_key=508ee1ec4aaf5c5bc0654504214df6f1&language=en-US&page=1&include_adult=false&query=#{query}"
    hash = JSON.parse(open(url).read)
    self.tmdb_id = hash['results'][0]['id']
  end

  def add_movies
    url = "https://api.themoviedb.org/3/person/#{tmdb_id}/combined_credits?api_key=508ee1ec4aaf5c5bc0654504214df6f1&language=en-US"
    hash = JSON.parse(open(url).read)
    hash['cast'].each do |movie|
      next_movie = Movie.find_by tmdb_id: movie['id']
      if next_movie
        movies << next_movie unless movies.include? next_movie
      else
        movies.create({ title: movie['title'], tmdb_id: movie['id'] }) 
      end
    end
  end
end
