class InstitutionsController < InheritedResources::Base

  def add_kind
    institution_kind = InstitutionKind.find params[:institution_kind]
    @kind = resource.kinds.where(:institution_kind_id => institution_kind).first
    @kind ||= Kind.new(:institution_kind_id => institution_kind.id, :institution => resource)
  end

end
