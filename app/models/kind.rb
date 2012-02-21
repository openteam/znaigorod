class Kind < ActiveRecord::Base
  belongs_to :institution_kind
  belongs_to :institution

  # All kind's of attributes
  has_many :attribute_strings
  has_many :attribute_booleans

  scope :published, includes(:institution).where(:institutions => {:published => true})

  def attributes
    @attributes ||= [attribute_strings.all + attribute_booleans.all].flatten.compact
  end

  def attributes_hash
    unless @attributes_hash
      @attributes_hash = {}
      Znaigorod::Application::Attribute::KINDS.keys.each do |key|
        @attributes_hash[key] = {}
        attribute_strings.each { |attr| @attributes_hash[key][attr.attribute_id] = attr }
      end
      build_hashes
    end
    @attributes_hash
  end

  def build_hashes
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

  def validate_kind
    result = valid?
    attributes_hash.each do |k,v|
      v.each do |id, attr|
        result = (result and attr.valid?)
      end
    end
    return result
  end

end
