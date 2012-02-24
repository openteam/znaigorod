class InstitutionKind < ActiveRecord::Base
  has_many :parameters, :dependent => :destroy
  has_many :kinds, :dependent => :destroy
  belongs_to :institution_class

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :institution_class_id

  scope :available_for, lambda {|institution| where('NOT id IN (?)', institution.kinds.map{|k| k.institution_kind_id} + [-1] )}
end
