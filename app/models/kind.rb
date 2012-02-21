class Kind < ActiveRecord::Base
  belongs_to :institution_kind
  belongs_to :institution

  # All kind's of attributes
  has_many :attribute_strings
  has_many :attribute_booleans

  def attributes
    @attributes ||= [attribute_strings.all + attribute_booleans.all].flatten.compact
  end

  def attributes_hash
    unless @attributes_hash
      @attributes_hash = {}
      @attributes_hash[:string] = attribute_strings.each_with_object({}) { |h, f| h[f.attribute_id] = f }
      @attributes_hash[:boolean] = attribute_booleans.each_with_object({}) { |h, f| h[f.attribute_id] = f }
      build
    end
    @attributes_hash
  end

private

  def build
    return unless institution_kind
    institution_kind.attributes.each do |attribute|
      unless attributes_hash[attribute.kind.to_sym][attribute.id]
        clazz = Znaigorod::Application::Attribute::KINDS[attribute.kind.to_sym]
        if clazz
          obj = clazz.new
          #obj.kind = self
          obj.attribute = attribute
          @attributes_hash[attribute.kind.to_sym][attribute.id] = obj
        end
      end
    end
  end

end
