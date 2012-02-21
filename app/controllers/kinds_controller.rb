class KindsController < InheritedResources::Base
  belongs_to :institution

  def create
    institution = Institution.find(params[:institution_id])
    institution_kind = InstitutionKind.find(params[:institution_kind])

    @kind = Kind.new(:institution => institution, :institution_kind => institution_kind)
    @kind.build_hashes

    params[:attribute].each do |type, attr|
      attributes = @kind.attributes_hash[type.to_sym]
      attr.each do |id, value|
        attributes[id.to_i].value = value
      end
    end

    if @kind.validate_kind
      ActiveRecord::Base.transaction do
        @kind.save

        logger.warn @kind.inspect
        @kind.attributes_hash.each do |kind, attributes|
          attributes.each do |id, attribute|
            logger.warn attribute.inspect
            attribute.kind = @kind
            attribute.save if attribute.value != nil
          end
        end
      end
      redirect_to institutions_path(institution)
      return
    end

    render 'institutions/add_kind'
  end
end
