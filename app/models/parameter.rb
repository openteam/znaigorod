class Parameter < ActiveRecord::Base
  belongs_to :institution_kind
  has_many :parameter_strings, :dependent => :destroy
  has_many :parameter_booleans, :dependent => :destroy

  KINDS = {:string => ParameterString, :boolean => ParameterBoolean}.freeze

  validates_presence_of :title
  validates_uniqueness_of :title, :scope => [:institution_kind_id]
  validates_presence_of :kind
  attr_readonly :kind
end
