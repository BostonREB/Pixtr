class User < ActiveRecord::Base
  include Clearance::User

  has_many :galleries
  has_many :images, through: :galleries  #finds images through the galleries
  has_many :comments
end
