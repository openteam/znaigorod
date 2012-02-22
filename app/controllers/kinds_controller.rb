class KindsController < InheritedResources::Base
  belongs_to :institution

  def new
    new! do
      if Kind.where(:institution_kind_id => params[:institution_kind], :institution_id => resource).any?
        redirect_to institution_path(resource)
        return
      end

      institution_kind = InstitutionKind.find params[:institution_kind]
      institution = Institution.find params[:institution_id]

      @kind =   institution.kinds.where(:institution_kind_id => institution_kind).first
      @kind ||= Kind.new(:institution_kind_id => institution_kind.id, :institution => institution)
    end
  end

  def update
    institution = Institution.find(params[:institution_id])
    @kind = Kind.where(:id => params[:id], :institution_id => institution).first
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
      redirect_to institution
      return
    end

    render 'show'
  end

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
      redirect_to institution
      return
    end

    render 'new'
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to resource.institution }
      failure.html { redirect_to resource.institution }
    end
  end
end
