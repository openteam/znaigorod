class AddPublishedToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :published, :boolean
  end
end
