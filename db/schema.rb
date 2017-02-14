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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170213131915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "data_derivation_codes", primary_key: "derivation_code", id: :text, force: :cascade do |t|
    t.text "description", null: false
  end

  create_table "facilities", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.geometry "location",                limit: {:srid=>0, :type=>"geometry"}
    t.string   "address1",                limit: 255
    t.string   "address2",                limit: 255
    t.string   "city",                    limit: 255
    t.string   "region",                  limit: 255
    t.string   "postal_code",             limit: 255
    t.integer  "max_occupancy"
    t.float    "square_meterage_storage"
    t.datetime "inserted_at",                                                   null: false
    t.datetime "updated_at",                                                    null: false
    t.index ["name"], name: "facilities_name_index", unique: true, using: :btree
  end

  create_table "food_groups", primary_key: "foodgroup_code", id: :string, limit: 255, force: :cascade do |t|
    t.string "foodgroup_desc", limit: 255
  end

  create_table "foods", primary_key: "ndb_no", id: :string, limit: 255, force: :cascade do |t|
    t.string  "foodgroup_code",     limit: 255, null: false
    t.string  "longdesc",           limit: 255, null: false
    t.string  "shortdesc",          limit: 255, null: false
    t.string  "common_name",        limit: 255
    t.string  "manufacturer_name",  limit: 255
    t.string  "survey",             limit: 255
    t.string  "refuse_description", limit: 255
    t.decimal "refuse"
    t.string  "scientific_name",    limit: 255
    t.decimal "n_factor"
    t.decimal "pro_factor"
    t.decimal "fat_factor"
    t.decimal "cho_factor"
  end

  create_table "footnotes", id: false, force: :cascade do |t|
    t.text "ndb_no"
    t.text "footnote_no"
    t.text "footnote_type"
    t.text "nutr_no"
    t.text "footnote_text", null: false
  end

  create_table "langua_l_desc", primary_key: "factor_code", id: :text, force: :cascade do |t|
    t.text "description", null: false
  end

  create_table "langua_l_factors", primary_key: ["ndb_no", "factor_code"], force: :cascade do |t|
    t.text "ndb_no",      null: false
    t.text "factor_code", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "iso_code",     limit: 255
    t.string   "english_name", limit: 255
    t.string   "native_name",  limit: 255
    t.datetime "inserted_at",              null: false
    t.datetime "updated_at",               null: false
    t.index ["iso_code"], name: "languages_iso_code_index", unique: true, using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "entree",            limit: 255
    t.string   "side_dish1",        limit: 255
    t.string   "side_dish2",        limit: 255
    t.string   "dessert",           limit: 255
    t.integer  "calories"
    t.integer  "calories_from_fat"
    t.integer  "calcium"
    t.integer  "sodium"
    t.integer  "cholesterol"
    t.integer  "carbohydrate"
    t.integer  "sugars"
    t.integer  "fat"
    t.integer  "saturated_fat"
    t.integer  "protein"
    t.integer  "fiber"
    t.decimal  "weight"
    t.string   "description",       limit: 255
    t.datetime "inserted_at",                   null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "nutrient_data", primary_key: ["ndb_no", "nutr_no"], force: :cascade do |t|
    t.text    "ndb_no",            null: false
    t.text    "nutr_no",           null: false
    t.decimal "nutrition_value",   null: false
    t.decimal "num_data_points",   null: false
    t.decimal "std_error"
    t.text    "source_code",       null: false
    t.text    "derivation_code"
    t.text    "ref_ndb_no"
    t.text    "add_nutr_mark"
    t.decimal "num_studies"
    t.decimal "min"
    t.decimal "max"
    t.decimal "degrees_freedom"
    t.decimal "low_error_bound"
    t.decimal "upper_error_bound"
    t.text    "stat_comments"
    t.text    "add_mod_date"
    t.text    "confidence_code"
  end

  create_table "nutrients", primary_key: "nutr_no", id: :text, force: :cascade do |t|
    t.text    "units",     null: false
    t.text    "tagname"
    t.text    "nutr_desc", null: false
    t.integer "num_dec",   null: false
    t.decimal "sr_order",  null: false
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.integer  "max_per_person"
    t.integer  "max_per_package"
    t.datetime "inserted_at",                 null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "source_codes", primary_key: "source_code", id: :text, force: :cascade do |t|
    t.text "description", null: false
  end

  create_table "sources_of_data", primary_key: "datasource_id", id: :text, force: :cascade do |t|
    t.text "authors"
    t.text "title",       null: false
    t.text "year"
    t.text "journal"
    t.text "vol_city"
    t.text "issue_state"
    t.text "start_page"
    t.text "end_page"
  end

  create_table "sources_of_data_assoc", primary_key: ["ndb_no", "nutr_no", "datasource_id"], force: :cascade do |t|
    t.text "ndb_no",        null: false
    t.text "nutr_no",       null: false
    t.text "datasource_id", null: false
  end

  create_table "stock_distributions", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "stock_id"
    t.integer  "user_food_package_id"
    t.datetime "inserted_at",          null: false
    t.datetime "updated_at",           null: false
    t.index ["stock_id"], name: "stock_distributions_stock_id_index", using: :btree
    t.index ["user_food_package_id"], name: "stock_distributions_user_food_package_id_index", using: :btree
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "quantity"
    t.datetime "arrival"
    t.datetime "expiration"
    t.integer  "reorder_quantity"
    t.string   "aisle",               limit: 255
    t.string   "row",                 limit: 255
    t.string   "shelf",               limit: 255
    t.string   "packaging",           limit: 255
    t.integer  "credits_per_package"
    t.string   "food_id",             limit: 255, null: false
    t.integer  "meal_id"
    t.integer  "offer_id"
    t.integer  "facility_id"
    t.datetime "inserted_at",                     null: false
    t.datetime "updated_at",                      null: false
    t.index ["facility_id"], name: "stocks_facility_id_index", using: :btree
    t.index ["food_id"], name: "stocks_food_id_index", using: :btree
  end

  create_table "user_food_packages", force: :cascade do |t|
    t.boolean  "ready_for_pickup", default: false, null: false
    t.boolean  "finalized",        default: false, null: false
    t.integer  "user_id"
    t.datetime "inserted_at",                      null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "user_food_packages_user_id_index", using: :btree
  end

  create_table "user_languages", force: :cascade do |t|
    t.boolean  "fluent",      default: false, null: false
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "inserted_at",                 null: false
    t.datetime "updated_at",                  null: false
    t.index ["language_id"], name: "user_languages_language_id_index", using: :btree
    t.index ["user_id"], name: "user_languages_user_id_index", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               limit: 255
    t.string   "name",                limit: 255
    t.string   "phone",               limit: 255
    t.boolean  "ok_to_text",                      default: false, null: false
    t.integer  "family_members"
    t.jsonb    "credits"
    t.integer  "facility_id"
    t.integer  "primary_language_id"
    t.datetime "inserted_at",                                     null: false
    t.datetime "updated_at",                                      null: false
    t.string   "password_hash",       limit: 255
    t.boolean  "admin"
    t.index ["email"], name: "users_email_index", unique: true, using: :btree
    t.index ["facility_id"], name: "users_facility_id_index", using: :btree
  end

  create_table "weights", primary_key: ["ndb_no", "seq"], force: :cascade do |t|
    t.text    "ndb_no",          null: false
    t.text    "seq",             null: false
    t.decimal "amount",          null: false
    t.text    "msre_desc",       null: false
    t.decimal "gram_weight",     null: false
    t.decimal "num_data_points"
    t.decimal "std_dev"
  end

  add_foreign_key "foods", "food_groups", column: "foodgroup_code", primary_key: "foodgroup_code", name: "foods_foodgroup_code_fkey"
  add_foreign_key "footnotes", "foods", column: "ndb_no", primary_key: "ndb_no", name: "footnotes_ndb_no_fkey"
  add_foreign_key "footnotes", "nutrients", column: "nutr_no", primary_key: "nutr_no", name: "footnotes_nutr_no_fkey"
  add_foreign_key "langua_l_factors", "foods", column: "ndb_no", primary_key: "ndb_no", name: "langua_l_factors_ndb_no_fkey"
  add_foreign_key "langua_l_factors", "langua_l_desc", column: "factor_code", primary_key: "factor_code", name: "langua_l_factors_factor_code_fkey"
  add_foreign_key "nutrient_data", "data_derivation_codes", column: "derivation_code", primary_key: "derivation_code", name: "nutrient_data_derivation_code_fkey"
  add_foreign_key "nutrient_data", "foods", column: "ndb_no", primary_key: "ndb_no", name: "nutrient_data_ndb_no_fkey"
  add_foreign_key "nutrient_data", "foods", column: "ref_ndb_no", primary_key: "ndb_no", name: "nutrient_data_ref_ndb_no_fkey"
  add_foreign_key "nutrient_data", "nutrients", column: "nutr_no", primary_key: "nutr_no", name: "nutrient_data_nutr_no_fkey"
  add_foreign_key "nutrient_data", "source_codes", column: "source_code", primary_key: "source_code", name: "nutrient_data_source_code_fkey"
  add_foreign_key "sources_of_data_assoc", "foods", column: "ndb_no", primary_key: "ndb_no", name: "sources_of_data_assoc_ndb_no_fkey"
  add_foreign_key "sources_of_data_assoc", "nutrients", column: "nutr_no", primary_key: "nutr_no", name: "sources_of_data_assoc_nutr_no_fkey"
  add_foreign_key "sources_of_data_assoc", "sources_of_data", column: "datasource_id", primary_key: "datasource_id", name: "sources_of_data_assoc_datasource_id_fkey"
  add_foreign_key "stock_distributions", "stocks", name: "stock_distributions_stock_id_fkey"
  add_foreign_key "stock_distributions", "user_food_packages", name: "stock_distributions_user_food_package_id_fkey"
  add_foreign_key "stocks", "facilities", name: "stocks_facility_id_fkey"
  add_foreign_key "stocks", "foods", primary_key: "ndb_no", name: "stocks_food_id_fkey"
  add_foreign_key "stocks", "meals", name: "stocks_meal_id_fkey"
  add_foreign_key "stocks", "offers", name: "stocks_offer_id_fkey"
  add_foreign_key "user_food_packages", "users", name: "user_food_packages_user_id_fkey"
  add_foreign_key "user_languages", "languages", name: "user_languages_language_id_fkey"
  add_foreign_key "user_languages", "users", name: "user_languages_user_id_fkey"
  add_foreign_key "users", "facilities", name: "users_facility_id_fkey"
  add_foreign_key "users", "languages", column: "primary_language_id", name: "users_primary_language_id_fkey"
  add_foreign_key "weights", "foods", column: "ndb_no", primary_key: "ndb_no", name: "weights_ndb_no_fkey"
end
