class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.integer :institution_kind_id
      t.string :title
      t.string :kind
      t.boolean :required
      t.boolean :searchable

      t.timestamps
    end
  end
end
