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

    if params[:parameter]
      params[:parameter].each do |type, attr|
        parameters = @kind.parameters_hash[type.to_sym]
        attr.each do |id, value|
          parameters[id.to_i].value = value
        end
      end
    end

    if @kind.validate_kind
      ActiveRecord::Base.transaction do
        @kind.save

        @kind.parameters_hash.each do |kind, parameters|
          parameters.each do |id, parameter|
            parameter.kind = @kind
            parameter.save if parameter.value != nil
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

    if params[:parameter]
      params[:parameter].each do |type, attr|
        parameters = @kind.parameters_hash[type.to_sym]
        attr.each do |id, value|
          parameters[id.to_i].value = value
        end
      end
    end

    if @kind.validate_kind
      ActiveRecord::Base.transaction do
        @kind.save

        @kind.parameters_hash.each do |kind, parameters|
          parameters.each do |id, parameter|
            parameter.kind = @kind
            parameter.save if parameter.value != nil
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
