class ParameterBoolean < ActiveRecord::Base
  belongs_to :parameter
  belongs_to :kind
end
