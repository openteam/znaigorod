class AttributeString < ActiveRecord::Base
  belongs_to :attribute
  belongs_to :kind

  validates_presence_of :value, :if => Proc.new { |attr| attr.attribute.required }
end