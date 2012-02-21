class CreateAttributeStrings < ActiveRecord::Migration
  def change
    create_table :attribute_strings do |t|
      t.integer :kind_id
      t.integer :attribute_id

      t.string :value
    end
  end
end
