class ParametersController < InheritedResources::Base
  belongs_to :institution_kind

  def create
    create! do |success, failure|
      success.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
      failure.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
    end
  end

  def update
    update! do |success, failure|
      success.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
      failure.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
      failure.html {redirect_to institution_class_institution_kind_path(resource.institution_kind.institution_class, resource.institution_kind) }
    end
  end

end
