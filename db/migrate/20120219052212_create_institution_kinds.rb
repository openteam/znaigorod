class CreateInstitutionKinds < ActiveRecord::Migration
  def change
    create_table :institution_kinds do |t|
      t.string :title, :null => false
      t.integer :institution_class_id, :null => false

      t.timestamps
    end

    add_index :institution_kinds, [:institution_class_id, :title], :unique => true
  end
end
