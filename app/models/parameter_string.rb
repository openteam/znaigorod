class ParameterString < ActiveRecord::Base
  belongs_to :parameter
  belongs_to :kind

  validates_presence_of :value, :if => Proc.new { |attr| attr.parameter.required }
end