class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.integer :institution_kind_id
      t.string :title
      t.string :kind
      t.boolean :required
      t.boolean :searchable

      t.timestamps
    end
  end
end
