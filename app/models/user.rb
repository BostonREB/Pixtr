class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries
  has_many :images, through: :galleries  #finds images through the galleries
  has_many :comments

  has_many :group_memberships, foreign_key: :member_id
  #using foreign_key because it is different
  has_many :groups, through: :group_memberships 

  has_many :following_relationships, foreign_key: :follower_id
  has_many :followed_users, through: :following_relationships
end
