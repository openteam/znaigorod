class Kind < ActiveRecord::Base
  belongs_to :institution_kind
  belongs_to :institution

  # All kind's of parameters
  has_many :parameter_strings, :dependent => :destroy
  has_many :parameter_booleans, :dependent => :destroy

  scope :published, includes(:institution).where(:institutions => {:published => true})

  def parameters
    @parameters ||= [parameter_strings.all + parameter_booleans.all].flatten.compact
  end

  def parameters_hash
    unless @parameters_hash
      @parameters_hash = {}
      Parameter::KINDS.keys.each do |key|
        @parameters_hash[key] = {}
        parameter_strings.each { |parameter| @parameters_hash[key][parameter.parameter_id] = parameter }
        parameter_booleans.each { |parameter| @parameters_hash[key][parameter.parameter_id] = parameter }
      end
      build_hashes
    end
    @parameters_hash
  end

  def build_hashes
    return unless institution_kind
    institution_kind.parameters.each do |parameter|
      unless parameters_hash[parameter.kind.to_sym][parameter.id]
        clazz = Parameter::KINDS[parameter.kind.to_sym]
        if clazz
          obj = clazz.new
          #obj.kind = self
          obj.parameter = parameter
          @parameters_hash[parameter.kind.to_sym][parameter.id] = obj
        end
      end
    end
  end

  def validate_kind
    result = valid?
    parameters_hash.each do |k,v|
      v.each do |id, attr|
        result = (result and attr.valid?)
      end
    end
    return result
  end

end
