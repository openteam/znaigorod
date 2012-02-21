class CreateInstitutionClasses < ActiveRecord::Migration
  def change
    create_table :institution_classes do |t|
      t.string :title, :null => false

      t.timestamps
    end

    add_index :institution_classes, [:title], :unique => true
  end
end
