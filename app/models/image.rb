class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  has_many :likes, as: :likable, dependent: :destroy

  has_many :user_likes, 
    through: :likes, source: :user

  
  # has_many provides:
  # def groups
  # def groups=
  # def group_ids
  # def group_ids=

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  # validates :name, :description, :url, presenbce: true  ##same as the above just different syntax

  def user
    gallery.user
  end
  
end