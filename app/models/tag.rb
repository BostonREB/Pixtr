class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :images, through: :taggings

  def self.search(search_params)
    query = search_params[:query]
    where("name ilike ?", "%#{query}%")
  end
end
