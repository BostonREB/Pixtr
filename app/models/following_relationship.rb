class FollowingRelationship < ActiveRecord::Base
  belongs_to :followed_user
  belongs_to :follower
end
