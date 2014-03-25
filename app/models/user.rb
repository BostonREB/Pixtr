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
    through: :likes, source: :image #source: tells rails to look for 

  def follow(other_user)
    follows = followed_user_relationships.create(followed_user: other_user)
    followers.each do |follower|
      follower.activities.create(
        subject: follows,
        type: "FollowingUserActivity")
    end
  end

  def unfollow(other_user)
    followed_users.destroy(other_user)
  end

  def following?(other_user)
    followed_user_ids.include? other_user.id
  end

  def join(group)
    joining_group = group_memberships.create(group: group)
    followers.each do |follower|
      follower.activities.create(
        subject: joining_group,
        type: "JoiningGroupActivity")
    end
  end

  def leave(group)
    groups.destroy(group)
  end

  def member?(group)
    group_ids.include? group.id
  end 

  def like(image)
    like = likes.create(image: image)
    followers.each do |follower|
      follower.activities.create(
        subject: like,
        type: "LikeActivity")
    end
  end

  def unlike(image)
    liked_images.destroy(image)
  end

  def liked?(image)
    liked_image_ids.include? image.id
  end

end
