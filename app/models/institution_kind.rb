class InstitutionKind < ActiveRecord::Base
  has_many :attributes
  has_many :kinds
  belongs_to :institution_class

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :institution_class_id
end
