class CreateParameterStrings < ActiveRecord::Migration
  def change
    create_table :parameter_strings do |t|
      t.integer :kind_id
      t.integer :parameter_id

      t.string :value
    end
  end
end
