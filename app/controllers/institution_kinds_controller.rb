class InstitutionKindsController < InheritedResources::Base
  belongs_to :institution_class

  def destroy
    destroy! do |success, failure|
      success.html {redirect_to resource.institution_class}
      success.html {redirect_to resource.institution_class}
    end
  end
end
