class InstitutionClass < ActiveRecord::Base
  has_many :institution_kinds

  validates_presence_of :title
  validates_uniqueness_of :title
end
