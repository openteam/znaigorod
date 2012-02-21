class InstitutionsController < InheritedResources::Base

  def add_kind
    if Kind.where(:institution_kind_id => params[:institution_kind], :institution_id => resource).any?
      redirect_to institution_path(resource)
      return
    end

    institution_kind = InstitutionKind.find params[:institution_kind]
    @kind = resource.kinds.where(:institution_kind_id => institution_kind).first
    @kind ||= Kind.new(:institution_kind_id => institution_kind.id, :institution => resource)
  end

end
