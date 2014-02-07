class Tag < ActiveRecord::Base
  attr_accessible :title

  has_many :secret_taggings
  has_many :secrets, through: :secret_taggings, source: :secret
end
