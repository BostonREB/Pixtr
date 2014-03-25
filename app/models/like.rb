class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  has_many :activities, as: :subject, dependent: :destroy

  validates :user_id,
    uniqueness: { scope: :image_id }
end