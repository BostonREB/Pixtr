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
    tags.pluck(:name).join(", ")  #calls method :name on all tags and returns array of those names, separated by commas
  end

  def tag_list=(tag_string)
    self.tags = Tag.from_tag_list(tag_string)
  end

  # def self.search(search_params)
  #   query = search_params[:query]
  #   tags = Tag.search(search_params)
  #   image_ids = Tagging.where(tag_id: tags).pluck(:image_id)
  #   where("name ILIKE :query OR description ILIKE :query OR id IN (:image_ids)", query: "%#{query}%", image_ids: image_ids)
  # end

  # def self.search(query)
  #   where("name ilike ? OR description ilike ?", "%#{query}%", "%#{query}%") 
  # end
  
end