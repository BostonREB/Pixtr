class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries  #finds images through the galleries
  has_many :comments

  has_many :activities

  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  #using foreign_key because it is different
  has_many :groups, through: :group_memberships 

  has_many :followed_user_relationships, 
    foreign_key: :follower_id,
    class_name: "FollowingRelationship", dependent: :destroy

  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship", dependent: :destroy

  has_many :followers, 
    through: :follower_relationships

  has_many :likes, dependent: :destroy

  has_many :liked_images,
    through: :likes, source: :likable, source_type: 'Image' #source: tells rails to look for 

  def follow(other_user)
    follows = followed_user_relationships.create(followed_user: other_user)
    notify_followers(follows, "FollowingUserActivity")
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user)
    followed_user_ids.include? other_user.id
  end

  def join(group)
      #groups << group  ##creates group_membership and returns an array of groups [<#group>, <#group>]
    joining_group = group_memberships.create(group: group)
      # creates group_membership but returns the single group_membership created <#group_membership>
    notify_followers(joining_group, "JoiningGroupActivity")
  end

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include? group.id
  end 

  def like(target)
    like = likes.create(likable: target)
    notify_followers(like, "LikeActivity")
  end

  def unlike(target)
    like = likes.find_by(likable: target)
    like.destroy
  end

  def likes?(target)
    likes.exists?(likable: target)
  end

  def notify_followers (subject, type)
    followers.each do |follower|
      follower.activities.create(
        subject: subject,  #polymorphic association
        type: type)  #single table inheritence
    end
  end
end
