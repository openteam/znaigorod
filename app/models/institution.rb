class Institution < ActiveRecord::Base
  has_many :kinds

  scope :published, where(:published => true)
end
