# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120221093554) do

  create_table "attribute_booleans", :force => true do |t|
    t.integer "kind_id"
    t.integer "attribute_id"
    t.boolean "value"
  end

  create_table "attribute_strings", :force => true do |t|
    t.integer "kind_id"
    t.integer "attribute_id"
    t.string  "value"
  end

  create_table "attributes", :force => true do |t|
    t.integer  "institution_kind_id"
    t.string   "title"
    t.string   "kind"
    t.boolean  "required"
    t.boolean  "searchable"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "institution_classes", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "institution_classes", ["title"], :name => "index_institution_classes_on_title", :unique => true

  create_table "institution_kinds", :force => true do |t|
    t.string   "title",                :null => false
    t.integer  "institution_class_id", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "institution_kinds", ["institution_class_id", "title"], :name => "index_institution_kinds_on_institution_class_id_and_title", :unique => true

  create_table "institutions", :force => true do |t|
    t.string   "title",             :null => false
    t.string   "address",           :null => false
    t.integer  "attributable_id"
    t.string   "attributable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.boolean  "published"
  end

  add_index "institutions", ["title", "address"], :name => "index_institutions_on_title_and_address"

  create_table "institutions_institution_kinds", :id => false, :force => true do |t|
    t.integer "institution_id"
    t.integer "institution_kind_id"
  end

  add_index "institutions_institution_kinds", ["institution_id", "institution_kind_id"], :name => "institutions_institution_kinds_idx", :unique => true

  create_table "kinds", :force => true do |t|
    t.integer  "institution_id"
    t.integer  "institution_kind_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
