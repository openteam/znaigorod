class CreateParameterBooleans < ActiveRecord::Migration
  def change
    create_table :parameter_booleans do |t|
      t.integer :kind_id
      t.integer :parameter_id

      t.boolean :value
    end
  end
end
