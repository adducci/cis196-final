class MatchesMovie < ActiveRecord::Base
  belongs_to :match
  belongs_to :movie
end
