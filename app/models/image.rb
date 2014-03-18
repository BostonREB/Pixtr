class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  # validates :name, :description, :url, presenbce: true  ##same as the above just different syntax

  def user
    gallery.user
  end
end