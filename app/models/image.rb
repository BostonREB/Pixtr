class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  has_many :likes, as: :likable, dependent: :destroy

  has_many :user_likes, 
    through: :likes, source: :user

  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  # validates :name, :description, :url, presenbce: true  ##same as the above just different syntax

  def user
    gallery.user
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).images
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
    joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")  #calls method :name on all tags and returns array of those names, separated by commas
  end

  def tag_list=(tag_string)
    tag_string.split(",").each do |tag_name|
        tag = Tag.find_or_create_by(:name, tag_name.strip.downcase)
        tags << tag
    end
  end
  
end