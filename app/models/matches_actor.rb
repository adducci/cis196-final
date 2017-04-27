class MatchesActor < ActiveRecord::Base
  belongs_to :match
  belongs_to :actor
end
