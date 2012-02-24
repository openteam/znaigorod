class Institution < ActiveRecord::Base
  has_many :kinds, :dependent => :destroy

  scope :published, where(:published => true)
end
