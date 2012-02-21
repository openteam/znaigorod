class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.integer :institution_id
      t.integer :institution_kind_id

      t.timestamps
    end
  end
end
