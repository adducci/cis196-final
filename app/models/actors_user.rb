class ActorsUser < ActiveRecord::Base
  belongs_to :actor
  belongs_to :user
end
