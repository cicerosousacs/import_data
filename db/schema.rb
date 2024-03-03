# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_02_233821) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "age_groups", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cnaes", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "cnpj_basic"
    t.string "name_company"
    t.bigint "legal_nature_id", null: false
    t.string "qualification_responsible"
    t.string "share_capital"
    t.bigint "company_size_id", null: false
    t.string "federative_entity_responsible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_size_id"], name: "index_companies_on_company_size_id"
    t.index ["legal_nature_id"], name: "index_companies_on_legal_nature_id"
  end

  create_table "company_sizes", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counties", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "establishments", force: :cascade do |t|
    t.string "cnpj_basic"
    t.string "cnpj_orde"
    t.string "cnpj_dv"
    t.string "identifier_office_branch"
    t.string "fantasy_name"
    t.bigint "registration_situation_id", null: false
    t.string "date_status_registration"
    t.bigint "registration_status_id", null: false
    t.string "city_name_outside"
    t.bigint "nation_id", null: false
    t.string "start_date_activity"
    t.bigint "cnae_id", null: false
    t.string "secondary_cnae"
    t.string "type_street"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "district"
    t.string "cep"
    t.string "uf"
    t.bigint "county_id", null: false
    t.integer "ddd_one"
    t.integer "telephone_one"
    t.integer "ddd_two"
    t.integer "telephone_two"
    t.integer "ddd_fax"
    t.integer "fax"
    t.string "email"
    t.string "special_situation"
    t.string "date_special_situation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cnae_id"], name: "index_establishments_on_cnae_id"
    t.index ["county_id"], name: "index_establishments_on_county_id"
    t.index ["nation_id"], name: "index_establishments_on_nation_id"
    t.index ["registration_situation_id"], name: "index_establishments_on_registration_situation_id"
    t.index ["registration_status_id"], name: "index_establishments_on_registration_status_id"
  end

  create_table "legal_natures", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nations", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partner_types", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners", force: :cascade do |t|
    t.string "cnpj_basic"
    t.bigint "partner_type_id", null: false
    t.string "name_partner"
    t.string "document_partner"
    t.bigint "qualification_partner_id", null: false
    t.string "date_entry_company"
    t.bigint "nation_id", null: false
    t.string "name_legal_representative"
    t.string "document_legal_representative"
    t.string "qualification_legal_representative"
    t.bigint "age_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["age_group_id"], name: "index_partners_on_age_group_id"
    t.index ["nation_id"], name: "index_partners_on_nation_id"
    t.index ["partner_type_id"], name: "index_partners_on_partner_type_id"
    t.index ["qualification_partner_id"], name: "index_partners_on_qualification_partner_id"
  end

  create_table "qualification_partners", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registration_situations", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registration_statuses", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_histories", force: :cascade do |t|
    t.string "type_history"
    t.date "date_history"
    t.string "name_history"
    t.jsonb "filters"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "simples", force: :cascade do |t|
    t.string "cnpj_basic"
    t.string "simple_option"
    t.string "date_option_simple"
    t.string "date_exclusion_simple"
    t.string "opting_for_mei"
    t.string "mei_option_date"
    t.string "date_exclusion_mei"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "companies", "company_sizes"
  add_foreign_key "companies", "legal_natures"
  add_foreign_key "establishments", "cnaes"
  add_foreign_key "establishments", "counties"
  add_foreign_key "establishments", "nations"
  add_foreign_key "establishments", "registration_situations"
  add_foreign_key "establishments", "registration_statuses"
  add_foreign_key "partners", "age_groups"
  add_foreign_key "partners", "nations"
  add_foreign_key "partners", "partner_types"
  add_foreign_key "partners", "qualification_partners"
end
