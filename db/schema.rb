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

ActiveRecord::Schema.define(version: 2020_05_24_173632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tenant_id"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["tenant_id", "created_at"], name: "index_activities_on_tenant_id_and_created_at"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name"
    t.index ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name"
  end

  create_table "answers", force: :cascade do |t|
    t.integer "question_id"
    t.text "text"
    t.integer "score", default: 0
    t.bigint "tenant_id"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delta", default: true, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["tenant_id"], name: "index_answers_on_tenant_id"
  end

  create_table "app_configs", force: :cascade do |t|
    t.integer "tenant_id"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_app_configs_on_key"
    t.index ["tenant_id"], name: "index_app_configs_on_tenant_id"
  end

  create_table "customized_pages", force: :cascade do |t|
    t.boolean "active", default: false
    t.integer "tenant_id"
    t.string "page"
    t.string "title"
    t.string "position1"
    t.text "header1"
    t.text "content1"
    t.string "position2"
    t.text "header2"
    t.text "content2"
    t.string "position3"
    t.text "header3"
    t.text "content3"
    t.string "position4"
    t.text "header4"
    t.text "content4"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page"], name: "index_customized_pages_on_page"
    t.index ["tenant_id", "page"], name: "index_customized_pages_on_tenant_id_and_page"
  end

  create_table "docs", force: :cascade do |t|
    t.string "doc_group_id"
    t.string "name"
    t.string "type"
    t.string "description"
    t.string "path"
    t.string "basepath"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basepath"], name: "index_docs_on_basepath"
    t.index ["doc_group_id"], name: "index_docs_on_doc_group_id"
  end

  create_table "file_assets", force: :cascade do |t|
    t.bigint "tenant_id"
    t.bigint "parent_id"
    t.string "type"
    t.bigint "topic_id"
    t.string "name"
    t.text "description"
    t.boolean "draft", default: false
    t.date "date"
    t.integer "runtime"
    t.string "slug"
    t.string "asset_file_name"
    t.string "asset_content_type"
    t.integer "asset_file_size"
    t.datetime "asset_updated_at"
    t.text "asset_meta"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.index ["aasm_state"], name: "index_file_assets_on_aasm_state"
    t.index ["draft"], name: "index_file_assets_on_draft"
    t.index ["parent_id"], name: "index_file_assets_on_parent_id"
    t.index ["slug"], name: "index_file_assets_on_slug", unique: true
    t.index ["tenant_id"], name: "index_file_assets_on_tenant_id"
    t.index ["topic_id"], name: "index_file_assets_on_topic_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "notes", force: :cascade do |t|
    t.string "path"
    t.string "title"
    t.text "content"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delta", default: true, null: false
    t.index ["path"], name: "index_notes_on_path"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "topic_id"
    t.string "title"
    t.text "text"
    t.bigint "tenant_id"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "delta", default: true, null: false
    t.index ["slug"], name: "index_questions_on_slug", unique: true
    t.index ["tenant_id"], name: "index_questions_on_tenant_id"
  end

  create_table "searchjoy_searches", force: :cascade do |t|
    t.integer "user_id"
    t.string "search_type"
    t.string "query"
    t.string "normalized_query"
    t.integer "results_count"
    t.datetime "created_at"
    t.integer "convertable_id"
    t.string "convertable_type"
    t.datetime "converted_at"
    t.index ["convertable_id", "convertable_type"], name: "index_searchjoy_searches_on_convertable_id_and_convertable_type"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_and_normalized_query_an"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "site_news", force: :cascade do |t|
    t.bigint "tenant_id"
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.integer "updater_id"
    t.index ["tenant_id", "created_at"], name: "index_site_news_on_tenant_id_and_created_at"
    t.index ["tenant_id"], name: "index_site_news_on_tenant_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "tenant_id"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name", "tenant_id"], name: "index_tags_on_name_and_tenant_id", unique: true
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "fqdn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "new_user_restriction", default: false
    t.string "self_serve_allowed_domain"
    t.string "safe_domains"
    t.boolean "default", default: false
    t.text "site_title"
    t.text "landing_page"
    t.text "footer"
    t.string "required_github_organization"
    t.text "github_auth_failure_message"
    t.index ["fqdn"], name: "index_tenants_on_fqdn"
    t.index ["subdomain"], name: "index_tenants_on_subdomain"
  end

  create_table "topic_files", force: :cascade do |t|
    t.bigint "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "asset_file_name"
    t.string "asset_content_type"
    t.bigint "asset_file_size"
    t.datetime "asset_updated_at"
    t.index ["topic_id"], name: "index_topic_files_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.integer "parent_topic_id"
    t.string "name"
    t.string "description"
    t.text "content"
    t.bigint "tenant_id"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "icon_file_name"
    t.string "icon_content_type"
    t.bigint "icon_file_size"
    t.datetime "icon_updated_at"
    t.boolean "delta", default: true, null: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.integer "children_count"
    t.integer "position"
    t.index ["slug"], name: "index_topics_on_slug", unique: true
    t.index ["tenant_id", "depth"], name: "index_topics_on_tenant_id_and_depth"
    t.index ["tenant_id", "lft"], name: "index_topics_on_tenant_id_and_lft"
    t.index ["tenant_id", "parent_topic_id"], name: "index_topics_on_tenant_id_and_parent_topic_id"
    t.index ["tenant_id", "rgt"], name: "index_topics_on_tenant_id_and_rgt"
    t.index ["tenant_id"], name: "index_topics_on_tenant_id"
  end

  create_table "transcode_remotes", force: :cascade do |t|
    t.integer "video_asset_id"
    t.integer "job_id"
    t.integer "status"
    t.text "response"
    t.datetime "last_checked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_asset_id"], name: "index_transcode_remotes_on_video_asset_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "notification_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notification_id"], name: "index_user_notifications_on_notification_id"
    t.index ["user_id", "notification_id"], name: "index_user_notifications_on_user_id_and_notification_id"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "avatar_url"
    t.boolean "admin"
    t.bigint "tenant_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false
    t.boolean "active", default: false
    t.string "hipchat_mention_name"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.bigint "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean "skip_confirmation", default: false
    t.boolean "skip_activation", default: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
  end

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id"
    t.string "foreign_key_name", null: false
    t.integer "foreign_key_id"
    t.index ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key"
    t.index ["version_id"], name: "index_version_associations_on_version_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.integer "transaction_id"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["transaction_id"], name: "index_versions_on_transaction_id"
  end

  create_table "video_access_secrets", force: :cascade do |t|
    t.bigint "video_asset_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_asset_id"], name: "index_video_access_secrets_on_video_asset_id"
  end

  create_table "video_attachments", force: :cascade do |t|
    t.integer "tenant_id"
    t.integer "video_asset_id"
    t.string "name"
    t.text "description"
    t.string "asset_file_name"
    t.string "asset_content_type"
    t.integer "asset_file_size"
    t.datetime "asset_updated_at"
    t.integer "creator_id"
    t.integer "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "delta", default: true, null: false
  end

  create_table "visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.integer "user_id"
    t.string "referring_domain"
    t.string "search_keyword"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.integer "screen_height"
    t.integer "screen_width"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "postal_code"
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["visit_token"], name: "index_visits_on_visit_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.bigint "votable_id"
    t.string "voter_type"
    t.bigint "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
    t.index ["voter_type", "voter_id"], name: "index_votes_on_voter_type_and_voter_id"
  end

end
