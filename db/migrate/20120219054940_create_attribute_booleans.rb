class CreateAttributeBooleans < ActiveRecord::Migration
  def change
    create_table :attribute_booleans do |t|
      t.integer :kind_id
      t.integer :attribute_id

      t.boolean :value
    end
  end
end
