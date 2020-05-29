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

ActiveRecord::Schema.define(version: 2020_05_28_155544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.bigint "trackable_id"
    t.string "trackable_type", limit: 191
    t.bigint "owner_id"
    t.string "owner_type", limit: 191
    t.string "key", limit: 255
    t.text "parameters"
    t.bigint "recipient_id"
    t.string "recipient_type", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "tenant_id"
    t.index ["owner_id", "owner_type"], name: "idx_31856_owner_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "idx_31856_recipient_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["tenant_id", "created_at"], name: "idx_31856_tenant_id"
    t.index ["tenant_id", "created_at"], name: "index_activities_on_tenant_id_and_created_at"
    t.index ["trackable_id", "trackable_type"], name: "idx_31856_trackable_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "trackable_id"
    t.string "trackable_type", limit: 191
    t.bigint "owner_id"
    t.string "owner_type", limit: 191
    t.string "key", limit: 255
    t.text "parameters"
    t.bigint "recipient_id"
    t.string "recipient_type", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "tenant_id"
    t.index ["owner_id", "owner_type"], name: "idx_31856_owner_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "idx_31856_recipient_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["tenant_id", "created_at"], name: "idx_31856_tenant_id"
    t.index ["tenant_id", "created_at"], name: "index_activities_on_tenant_id_and_created_at"
    t.index ["trackable_id", "trackable_type"], name: "idx_31856_trackable_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name", limit: 191
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "idx_31865_index_ahoy_events_on_name_and_time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "idx_31865_index_ahoy_events_on_user_id_and_name"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "idx_31865_index_ahoy_events_on_visit_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name", limit: 191
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "idx_31865_index_ahoy_events_on_name_and_time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "idx_31865_index_ahoy_events_on_user_id_and_name"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "idx_31865_index_ahoy_events_on_visit_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.text "text"
    t.bigint "score", default: 0
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.index ["question_id"], name: "idx_31874_question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["tenant_id"], name: "idx_31874_tenant_id"
    t.index ["tenant_id"], name: "index_answers_on_tenant_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.text "text"
    t.bigint "score", default: 0
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.index ["question_id"], name: "idx_31874_question_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["tenant_id"], name: "idx_31874_tenant_id"
    t.index ["tenant_id"], name: "index_answers_on_tenant_id"
  end

  create_table "app_configs", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "key", limit: 191
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "idx_31885_index_app_configs_on_key"
    t.index ["key"], name: "index_app_configs_on_key"
    t.index ["tenant_id"], name: "idx_31885_index_app_configs_on_tenant_id"
    t.index ["tenant_id"], name: "index_app_configs_on_tenant_id"
  end

  create_table "app_configs", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "key", limit: 191
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["key"], name: "idx_31885_index_app_configs_on_key"
    t.index ["key"], name: "index_app_configs_on_key"
    t.index ["tenant_id"], name: "idx_31885_index_app_configs_on_tenant_id"
    t.index ["tenant_id"], name: "index_app_configs_on_tenant_id"
  end

  create_table "customized_pages", force: :cascade do |t|
    t.boolean "active", default: false
    t.bigint "tenant_id"
    t.string "page", limit: 191
    t.string "title", limit: 255
    t.string "position1", limit: 255
    t.text "header1"
    t.text "content1"
    t.string "position2", limit: 255
    t.text "header2"
    t.text "content2"
    t.string "position3", limit: 255
    t.text "header3"
    t.text "content3"
    t.string "position4", limit: 255
    t.text "header4"
    t.text "content4"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page"], name: "idx_31891_index_customized_pages_on_page"
    t.index ["page"], name: "index_customized_pages_on_page"
    t.index ["tenant_id", "page"], name: "idx_31891_index_customized_pages_on_tenant_id_and_page"
    t.index ["tenant_id", "page"], name: "index_customized_pages_on_tenant_id_and_page"
  end

  create_table "customized_pages", force: :cascade do |t|
    t.boolean "active", default: false
    t.bigint "tenant_id"
    t.string "page", limit: 191
    t.string "title", limit: 255
    t.string "position1", limit: 255
    t.text "header1"
    t.text "content1"
    t.string "position2", limit: 255
    t.text "header2"
    t.text "content2"
    t.string "position3", limit: 255
    t.text "header3"
    t.text "content3"
    t.string "position4", limit: 255
    t.text "header4"
    t.text "content4"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["page"], name: "idx_31891_index_customized_pages_on_page"
    t.index ["page"], name: "index_customized_pages_on_page"
    t.index ["tenant_id", "page"], name: "idx_31891_index_customized_pages_on_tenant_id_and_page"
    t.index ["tenant_id", "page"], name: "index_customized_pages_on_tenant_id_and_page"
  end

  create_table "docs", force: :cascade do |t|
    t.string "doc_group_id", limit: 191
    t.string "name", limit: 255
    t.string "type", limit: 255
    t.string "description", limit: 255
    t.string "path", limit: 255
    t.string "basepath", limit: 191
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["basepath"], name: "idx_31901_index_docs_on_basepath"
    t.index ["basepath"], name: "index_docs_on_basepath"
    t.index ["doc_group_id"], name: "idx_31901_index_docs_on_doc_group_id"
    t.index ["doc_group_id"], name: "index_docs_on_doc_group_id"
  end

  create_table "docs", force: :cascade do |t|
    t.string "doc_group_id", limit: 191
    t.string "name", limit: 255
    t.string "type", limit: 255
    t.string "description", limit: 255
    t.string "path", limit: 255
    t.string "basepath", limit: 191
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["basepath"], name: "idx_31901_index_docs_on_basepath"
    t.index ["basepath"], name: "index_docs_on_basepath"
    t.index ["doc_group_id"], name: "idx_31901_index_docs_on_doc_group_id"
    t.index ["doc_group_id"], name: "index_docs_on_doc_group_id"
  end

  create_table "file_assets", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "parent_id"
    t.string "type", limit: 255
    t.bigint "topic_id"
    t.string "name", limit: 255
    t.text "description"
    t.boolean "draft", default: false
    t.date "date"
    t.bigint "runtime"
    t.string "slug", limit: 255
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.text "asset_meta"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "aasm_state", limit: 191
    t.index ["aasm_state"], name: "idx_31910_index_file_assets_on_aasm_state"
    t.index ["aasm_state"], name: "index_file_assets_on_aasm_state"
    t.index ["draft"], name: "index_file_assets_on_draft"
    t.index ["parent_id"], name: "index_file_assets_on_parent_id"
    t.index ["slug"], name: "index_file_assets_on_slug", unique: true
    t.index ["tenant_id"], name: "idx_31910_index_file_assets_on_tenant_id"
    t.index ["tenant_id"], name: "index_file_assets_on_tenant_id"
    t.index ["topic_id"], name: "index_file_assets_on_topic_id"
  end

  create_table "file_assets", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "parent_id"
    t.string "type", limit: 255
    t.bigint "topic_id"
    t.string "name", limit: 255
    t.text "description"
    t.boolean "draft", default: false
    t.date "date"
    t.bigint "runtime"
    t.string "slug", limit: 255
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.text "asset_meta"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "aasm_state", limit: 191
    t.index ["aasm_state"], name: "idx_31910_index_file_assets_on_aasm_state"
    t.index ["aasm_state"], name: "index_file_assets_on_aasm_state"
    t.index ["draft"], name: "index_file_assets_on_draft"
    t.index ["parent_id"], name: "index_file_assets_on_parent_id"
    t.index ["slug"], name: "index_file_assets_on_slug", unique: true
    t.index ["tenant_id"], name: "idx_31910_index_file_assets_on_tenant_id"
    t.index ["tenant_id"], name: "index_file_assets_on_tenant_id"
    t.index ["topic_id"], name: "index_file_assets_on_topic_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", limit: 191, null: false
    t.bigint "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "idx_31920_slug"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "idx_31920_sluggable_id"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "idx_31920_sluggable_type"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", limit: 191, null: false
    t.bigint "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "idx_31920_slug"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "idx_31920_sluggable_id"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "idx_31920_sluggable_type"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "notes", force: :cascade do |t|
    t.string "path", limit: 191
    t.string "title", limit: 255
    t.text "content"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.index ["path"], name: "idx_31929_index_notes_on_path"
    t.index ["path"], name: "index_notes_on_path"
  end

  create_table "notes", force: :cascade do |t|
    t.string "path", limit: 191
    t.string "title", limit: 255
    t.text "content"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
    t.index ["path"], name: "idx_31929_index_notes_on_path"
    t.index ["path"], name: "index_notes_on_path"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title", limit: 255
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "topic_id"
    t.string "title", limit: 255
    t.text "text"
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.boolean "delta", default: true, null: false
    t.index ["slug"], name: "index_questions_on_slug", unique: true
    t.index ["tenant_id"], name: "idx_31948_tenant_id"
    t.index ["tenant_id"], name: "index_questions_on_tenant_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "topic_id"
    t.string "title", limit: 255
    t.text "text"
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.boolean "delta", default: true, null: false
    t.index ["slug"], name: "index_questions_on_slug", unique: true
    t.index ["tenant_id"], name: "idx_31948_tenant_id"
    t.index ["tenant_id"], name: "index_questions_on_tenant_id"
  end

  create_table "searchjoy_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "search_type", limit: 191
    t.string "query", limit: 255
    t.string "normalized_query", limit: 191
    t.bigint "results_count"
    t.datetime "created_at"
    t.bigint "convertable_id"
    t.string "convertable_type", limit: 191
    t.datetime "converted_at"
    t.index ["convertable_id", "convertable_type"], name: "idx_31961_index_searchjoy_searches_on_convertable_id_and_conver"
    t.index ["convertable_id", "convertable_type"], name: "index_searchjoy_searches_on_convertable_id_and_convertable_type"
    t.index ["created_at"], name: "idx_31961_index_searchjoy_searches_on_created_at"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "idx_31961_index_searchjoy_searches_on_search_type_and_created_a"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "idx_31961_index_searchjoy_searches_on_search_type_and_normalize"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_and_normalized_query_an"
  end

  create_table "searchjoy_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "search_type", limit: 191
    t.string "query", limit: 255
    t.string "normalized_query", limit: 191
    t.bigint "results_count"
    t.datetime "created_at"
    t.bigint "convertable_id"
    t.string "convertable_type", limit: 191
    t.datetime "converted_at"
    t.index ["convertable_id", "convertable_type"], name: "idx_31961_index_searchjoy_searches_on_convertable_id_and_conver"
    t.index ["convertable_id", "convertable_type"], name: "index_searchjoy_searches_on_convertable_id_and_convertable_type"
    t.index ["created_at"], name: "idx_31961_index_searchjoy_searches_on_created_at"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "idx_31961_index_searchjoy_searches_on_search_type_and_created_a"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "idx_31961_index_searchjoy_searches_on_search_type_and_normalize"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_and_normalized_query_an"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", limit: 191, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "idx_31970_session_id"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "idx_31970_updated_at"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", limit: 191, null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "idx_31970_session_id"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "idx_31970_updated_at"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", limit: 255, null: false
    t.text "value"
    t.bigint "target_id", null: false
    t.string "target_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", limit: 255, null: false
    t.text "value"
    t.bigint "target_id", null: false
    t.string "target_type", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "site_news", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "title", limit: 255
    t.text "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.index ["tenant_id", "created_at"], name: "idx_31988_tenant_id"
    t.index ["tenant_id", "created_at"], name: "index_site_news_on_tenant_id_and_created_at"
    t.index ["tenant_id"], name: "index_site_news_on_tenant_id"
  end

  create_table "site_news", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "title", limit: 255
    t.text "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.index ["tenant_id", "created_at"], name: "idx_31988_tenant_id"
    t.index ["tenant_id", "created_at"], name: "index_site_news_on_tenant_id_and_created_at"
    t.index ["tenant_id"], name: "index_site_news_on_tenant_id"
  end

  create_table "site_stats", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "name"
    t.json "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_site_stats_on_name"
    t.index ["tenant_id"], name: "index_site_stats_on_tenant_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "taggable_id"
    t.string "taggable_type", limit: 191
    t.bigint "tagger_id"
    t.string "tagger_type", limit: 191
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "idx_31997_taggings_idx", unique: true
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "idx_31997_index_taggings_on_taggable_id_and_taggable_type_and_c"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.bigint "taggable_id"
    t.string "taggable_type", limit: 191
    t.bigint "tagger_id"
    t.string "tagger_type", limit: 191
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "idx_31997_taggings_idx", unique: true
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "idx_31997_index_taggings_on_taggable_id_and_taggable_type_and_c"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 191
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "taggings_count", default: 0
    t.index ["name", "tenant_id"], name: "idx_32006_index_tags_on_name_and_tenant_id", unique: true
    t.index ["name", "tenant_id"], name: "index_tags_on_name_and_tenant_id", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 191
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "taggings_count", default: 0
    t.index ["name", "tenant_id"], name: "idx_32006_index_tags_on_name_and_tenant_id", unique: true
    t.index ["name", "tenant_id"], name: "index_tags_on_name_and_tenant_id", unique: true
  end

  create_table "tags_original", force: :cascade do |t|
    t.string "name", limit: 191
    t.text "description"
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "idx_32013_name"
    t.index ["tenant_id"], name: "idx_32013_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "subdomain", limit: 191
    t.string "fqdn", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "new_user_restriction", default: false
    t.string "self_serve_allowed_domain", limit: 255
    t.string "safe_domains", limit: 255
    t.boolean "default", default: false
    t.text "site_title"
    t.text "landing_page"
    t.text "footer"
    t.string "required_github_organization", limit: 255
    t.text "github_auth_failure_message"
    t.index ["fqdn"], name: "idx_32022_domain"
    t.index ["fqdn"], name: "index_tenants_on_fqdn"
    t.index ["subdomain"], name: "idx_32022_subdomain"
    t.index ["subdomain"], name: "index_tenants_on_subdomain"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "subdomain", limit: 191
    t.string "fqdn", limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "new_user_restriction", default: false
    t.string "self_serve_allowed_domain", limit: 255
    t.string "safe_domains", limit: 255
    t.boolean "default", default: false
    t.text "site_title"
    t.text "landing_page"
    t.text "footer"
    t.string "required_github_organization", limit: 255
    t.text "github_auth_failure_message"
    t.index ["fqdn"], name: "idx_32022_domain"
    t.index ["fqdn"], name: "index_tenants_on_fqdn"
    t.index ["subdomain"], name: "idx_32022_subdomain"
    t.index ["subdomain"], name: "index_tenants_on_subdomain"
  end

  create_table "topic_files", force: :cascade do |t|
    t.bigint "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.index ["topic_id"], name: "index_topic_files_on_topic_id"
  end

  create_table "topic_files", force: :cascade do |t|
    t.bigint "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.index ["topic_id"], name: "index_topic_files_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.bigint "parent_topic_id"
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.text "content"
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "icon_file_name", limit: 255
    t.string "icon_content_type", limit: 255
    t.bigint "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean "delta", default: true, null: false
    t.bigint "lft"
    t.bigint "rgt"
    t.bigint "depth"
    t.bigint "children_count"
    t.bigint "position"
    t.index ["slug"], name: "index_topics_on_slug", unique: true
    t.index ["tenant_id", "depth"], name: "idx_32033_index_topics_on_tenant_id_and_depth"
    t.index ["tenant_id", "depth"], name: "index_topics_on_tenant_id_and_depth"
    t.index ["tenant_id", "lft"], name: "idx_32033_index_topics_on_tenant_id_and_lft"
    t.index ["tenant_id", "lft"], name: "index_topics_on_tenant_id_and_lft"
    t.index ["tenant_id", "parent_topic_id"], name: "idx_32033_index_topics_on_tenant_id_and_parent_topic_id"
    t.index ["tenant_id", "parent_topic_id"], name: "index_topics_on_tenant_id_and_parent_topic_id"
    t.index ["tenant_id", "rgt"], name: "idx_32033_index_topics_on_tenant_id_and_rgt"
    t.index ["tenant_id", "rgt"], name: "index_topics_on_tenant_id_and_rgt"
    t.index ["tenant_id"], name: "idx_32033_tenant_id"
    t.index ["tenant_id"], name: "index_topics_on_tenant_id"
  end

  create_table "topics", force: :cascade do |t|
    t.bigint "parent_topic_id"
    t.string "name", limit: 255
    t.string "description", limit: 255
    t.text "content"
    t.bigint "tenant_id"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "icon_file_name", limit: 255
    t.string "icon_content_type", limit: 255
    t.bigint "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean "delta", default: true, null: false
    t.bigint "lft"
    t.bigint "rgt"
    t.bigint "depth"
    t.bigint "children_count"
    t.bigint "position"
    t.index ["slug"], name: "index_topics_on_slug", unique: true
    t.index ["tenant_id", "depth"], name: "idx_32033_index_topics_on_tenant_id_and_depth"
    t.index ["tenant_id", "depth"], name: "index_topics_on_tenant_id_and_depth"
    t.index ["tenant_id", "lft"], name: "idx_32033_index_topics_on_tenant_id_and_lft"
    t.index ["tenant_id", "lft"], name: "index_topics_on_tenant_id_and_lft"
    t.index ["tenant_id", "parent_topic_id"], name: "idx_32033_index_topics_on_tenant_id_and_parent_topic_id"
    t.index ["tenant_id", "parent_topic_id"], name: "index_topics_on_tenant_id_and_parent_topic_id"
    t.index ["tenant_id", "rgt"], name: "idx_32033_index_topics_on_tenant_id_and_rgt"
    t.index ["tenant_id", "rgt"], name: "index_topics_on_tenant_id_and_rgt"
    t.index ["tenant_id"], name: "idx_32033_tenant_id"
    t.index ["tenant_id"], name: "index_topics_on_tenant_id"
  end

  create_table "transcode_remotes", force: :cascade do |t|
    t.bigint "video_asset_id"
    t.bigint "job_id"
    t.bigint "status"
    t.text "response"
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_asset_id"], name: "idx_32052_index_transcode_remotes_on_video_asset_id"
    t.index ["video_asset_id"], name: "index_transcode_remotes_on_video_asset_id"
  end

  create_table "transcode_remotes", force: :cascade do |t|
    t.bigint "video_asset_id"
    t.bigint "job_id"
    t.bigint "status"
    t.text "response"
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_asset_id"], name: "idx_32052_index_transcode_remotes_on_video_asset_id"
    t.index ["video_asset_id"], name: "index_transcode_remotes_on_video_asset_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notification_id"
    t.boolean "read", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["notification_id"], name: "idx_32077_index_user_notifications_on_notification_id"
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id", "notification_id"], name: "idx_32077_index_user_notifications_on_user_id_and_notification_"
    t.index ["user_id", "notification_id"], name: "index_user_notifications_on_user_id_and_notification_id"
    t.index ["user_id"], name: "idx_32077_index_user_notifications_on_user_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notification_id"
    t.boolean "read", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["notification_id"], name: "idx_32077_index_user_notifications_on_notification_id"
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id", "notification_id"], name: "idx_32077_index_user_notifications_on_user_id_and_notification_"
    t.index ["user_id", "notification_id"], name: "index_user_notifications_on_user_id_and_notification_id"
    t.index ["user_id"], name: "idx_32077_index_user_notifications_on_user_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", limit: 255
    t.string "uid", limit: 255
    t.string "name", limit: 255
    t.string "avatar_url", limit: 255
    t.boolean "admin"
    t.bigint "tenant_id"
    t.string "email", limit: 255, default: ""
    t.string "encrypted_password", limit: 255, default: ""
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "approved", default: false
    t.boolean "active", default: true
    t.string "hipchat_mention_name", limit: 255
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean "skip_confirmation", default: false
    t.boolean "skip_activation", default: false
    t.index ["approved"], name: "idx_32061_approved"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", limit: 255
    t.string "uid", limit: 255
    t.string "name", limit: 255
    t.string "avatar_url", limit: 255
    t.boolean "admin"
    t.bigint "tenant_id"
    t.string "email", limit: 255, default: ""
    t.string "encrypted_password", limit: 255, default: ""
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "confirmation_token", limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "approved", default: false
    t.boolean "active", default: true
    t.string "hipchat_mention_name", limit: 255
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean "skip_confirmation", default: false
    t.boolean "skip_activation", default: false
    t.index ["approved"], name: "idx_32061_approved"
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  create_table "version_associations", force: :cascade do |t|
    t.bigint "version_id"
    t.string "foreign_key_name", limit: 191, null: false
    t.bigint "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "idx_32093_index_version_associations_on_foreign_key"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "idx_32093_index_version_associations_on_version_id"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "version_associations", force: :cascade do |t|
    t.bigint "version_id"
    t.string "foreign_key_name", limit: 191, null: false
    t.bigint "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "idx_32093_index_version_associations_on_foreign_key"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "idx_32093_index_version_associations_on_version_id"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.bigint "transaction_id"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "idx_32084_item_type"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "idx_32084_index_versions_on_transaction_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", limit: 191, null: false
    t.bigint "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.bigint "transaction_id"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "idx_32084_item_type"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "idx_32084_index_versions_on_transaction_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "video_access_secrets", force: :cascade do |t|
    t.bigint "video_asset_id"
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_asset_id"], name: "idx_32099_index_video_access_secrets_on_video_asset_id"
    t.index ["video_asset_id"], name: "index_video_access_secrets_on_video_asset_id"
  end

  create_table "video_access_secrets", force: :cascade do |t|
    t.bigint "video_asset_id"
    t.string "value", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["video_asset_id"], name: "idx_32099_index_video_access_secrets_on_video_asset_id"
    t.index ["video_asset_id"], name: "index_video_access_secrets_on_video_asset_id"
  end

  create_table "video_attachments", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "video_asset_id"
    t.string "name", limit: 255
    t.text "description"
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
  end

  create_table "video_attachments", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "video_asset_id"
    t.string "name", limit: 255
    t.text "description"
    t.string "asset_file_name", limit: 255
    t.string "asset_content_type", limit: 255
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "delta", default: true, null: false
  end

  create_table "visits", force: :cascade do |t|
    t.string "visit_token", limit: 191
    t.string "visitor_token", limit: 255
    t.string "ip", limit: 255
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.bigint "user_id"
    t.string "referring_domain", limit: 255
    t.string "search_keyword", limit: 255
    t.string "browser", limit: 255
    t.string "os", limit: 255
    t.string "device_type", limit: 255
    t.bigint "screen_height"
    t.bigint "screen_width"
    t.string "country", limit: 255
    t.string "region", limit: 255
    t.string "city", limit: 255
    t.string "postal_code", limit: 255
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "utm_source", limit: 255
    t.string "utm_medium", limit: 255
    t.string "utm_term", limit: 255
    t.string "utm_content", limit: 255
    t.string "utm_campaign", limit: 255
    t.datetime "started_at"
    t.index ["user_id"], name: "idx_32115_index_visits_on_user_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visit_token"], name: "idx_32115_index_visits_on_visit_token", unique: true
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string "visit_token", limit: 191
    t.string "visitor_token", limit: 255
    t.string "ip", limit: 255
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.bigint "user_id"
    t.string "referring_domain", limit: 255
    t.string "search_keyword", limit: 255
    t.string "browser", limit: 255
    t.string "os", limit: 255
    t.string "device_type", limit: 255
    t.bigint "screen_height"
    t.bigint "screen_width"
    t.string "country", limit: 255
    t.string "region", limit: 255
    t.string "city", limit: 255
    t.string "postal_code", limit: 255
    t.decimal "latitude", precision: 10
    t.decimal "longitude", precision: 10
    t.string "utm_source", limit: 255
    t.string "utm_medium", limit: 255
    t.string "utm_term", limit: 255
    t.string "utm_content", limit: 255
    t.string "utm_campaign", limit: 255
    t.datetime "started_at"
    t.index ["user_id"], name: "idx_32115_index_visits_on_user_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visit_token"], name: "idx_32115_index_visits_on_visit_token", unique: true
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "votable_id"
    t.string "votable_type", limit: 191
    t.bigint "voter_id"
    t.string "voter_type", limit: 191
    t.boolean "vote_flag"
    t.string "vote_scope", limit: 191
    t.bigint "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "idx_32124_index_votes_on_votable_id_and_votable_type_and_vote_s"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "idx_32124_index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "votable_id"
    t.string "votable_type", limit: 191
    t.bigint "voter_id"
    t.string "voter_type", limit: 191
    t.boolean "vote_flag"
    t.string "vote_scope", limit: 191
    t.bigint "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "idx_32124_index_votes_on_votable_id_and_votable_type_and_vote_s"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "idx_32124_index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

  add_foreign_key "site_stats", "tenants"
end
