class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :title, :null => false
      t.string :address, :null => false

      t.timestamps
    end

    add_index :institutions, [:title, :address]
  end
end
