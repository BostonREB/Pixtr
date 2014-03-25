class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  has_many :gallery_activities, as: :subject, dependent: :destroy

  has_many :likes, as: :likable, dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true  ##makes sure that a valid user exists.  More secure than just using user_id
end