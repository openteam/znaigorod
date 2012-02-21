class AttributeString < ActiveRecord::Base
  belongs_to :attribute
  belongs_to :kind
end
