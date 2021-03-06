class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  validates :body, presence: true

  has_many :activities, as: :subject, dependent: :destroy

  def self.newest #scopes
    order(created_at: :desc)
  end

  # scope :newest, -> {order(created_at: :desc)} ##different way of writing the same scope
end
