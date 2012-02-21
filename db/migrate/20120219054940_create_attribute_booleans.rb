class CreateAttributeBooleans < ActiveRecord::Migration
  def change
    create_table :attribute_booleans do |t|
      t.integer :institution_id
      t.integer :attribute_id

      t.boolean :value
    end
  end
end
