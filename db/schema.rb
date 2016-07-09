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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160709155615) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters",     limit: 65535
    t.integer  "recipient_id",   limit: 4
    t.string   "recipient_type", limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "tenant_id",      limit: 4
  end

  add_index "activities", ["owner_id", "owner_type"], name: "owner_id", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "recipient_id", using: :btree
  add_index "activities", ["tenant_id", "created_at"], name: "tenant_id", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "trackable_id", using: :btree

  create_table "ahoy_events", force: :cascade do |t|
    t.integer  "visit_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.text     "properties", limit: 65535
    t.datetime "time"
  end

  add_index "ahoy_events", ["name", "time"], name: "index_ahoy_events_on_name_and_time", using: :btree
  add_index "ahoy_events", ["user_id", "name"], name: "index_ahoy_events_on_user_id_and_name", using: :btree
  add_index "ahoy_events", ["visit_id", "name"], name: "index_ahoy_events_on_visit_id_and_name", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "text",        limit: 65535
    t.integer  "score",       limit: 4,     default: 0
    t.integer  "tenant_id",   limit: 4
    t.integer  "creator_id",  limit: 4
    t.integer  "updater_id",  limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "delta",                     default: true, null: false
  end

  add_index "answers", ["question_id"], name: "question_id", using: :btree
  add_index "answers", ["tenant_id"], name: "tenant_id", using: :btree

  create_table "app_configs", force: :cascade do |t|
    t.integer  "tenant_id",  limit: 4
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_configs", ["key"], name: "index_app_configs_on_key", using: :btree
  add_index "app_configs", ["tenant_id"], name: "index_app_configs_on_tenant_id", using: :btree

  create_table "customized_pages", force: :cascade do |t|
    t.boolean  "active",                   default: false
    t.integer  "tenant_id",  limit: 4
    t.string   "page",       limit: 255
    t.string   "title",      limit: 255
    t.string   "position1",  limit: 255
    t.text     "header1",    limit: 65535
    t.text     "content1",   limit: 65535
    t.string   "position2",  limit: 255
    t.text     "header2",    limit: 65535
    t.text     "content2",   limit: 65535
    t.string   "position3",  limit: 255
    t.text     "header3",    limit: 65535
    t.text     "content3",   limit: 65535
    t.string   "position4",  limit: 255
    t.text     "header4",    limit: 65535
    t.text     "content4",   limit: 65535
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customized_pages", ["page"], name: "index_customized_pages_on_page", using: :btree
  add_index "customized_pages", ["tenant_id", "page"], name: "index_customized_pages_on_tenant_id_and_page", using: :btree

  create_table "docs", force: :cascade do |t|
    t.string   "doc_group_id", limit: 255
    t.string   "name",         limit: 255
    t.string   "type",         limit: 255
    t.string   "description",  limit: 255
    t.string   "path",         limit: 255
    t.string   "basepath",     limit: 255
    t.text     "data",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "docs", ["basepath"], name: "index_docs_on_basepath", using: :btree
  add_index "docs", ["doc_group_id"], name: "index_docs_on_doc_group_id", using: :btree

  create_table "file_assets", force: :cascade do |t|
    t.integer  "tenant_id",          limit: 4
    t.integer  "parent_id",          limit: 4
    t.string   "type",               limit: 255
    t.integer  "topic_id",           limit: 4
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.boolean  "draft",                            default: false
    t.date     "date"
    t.integer  "runtime",            limit: 4
    t.string   "slug",               limit: 255
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at"
    t.text     "asset_meta",         limit: 65535
    t.integer  "creator_id",         limit: 4
    t.integer  "updater_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state",         limit: 255
  end

  add_index "file_assets", ["aasm_state"], name: "index_file_assets_on_aasm_state", using: :btree
  add_index "file_assets", ["tenant_id"], name: "index_file_assets_on_tenant_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at",                 null: false
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "slug", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "sluggable_type", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "path",       limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "delta",                    default: true, null: false
  end

  add_index "notes", ["path"], name: "index_notes_on_path", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "topic_id",   limit: 4
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.integer  "tenant_id",  limit: 4
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "slug",       limit: 255
    t.boolean  "delta",                    default: true, null: false
  end

  add_index "questions", ["tenant_id"], name: "tenant_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "sessions", ["session_id"], name: "session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",         limit: 255,   null: false
    t.text     "value",       limit: 65535
    t.integer  "target_id",   limit: 4,     null: false
    t.string   "target_type", limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "site_news", force: :cascade do |t|
    t.integer  "tenant_id",  limit: 4
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
  end

  add_index "site_news", ["tenant_id", "created_at"], name: "tenant_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "tenant_id",      limit: 4
    t.integer  "creator_id",     limit: 4
    t.integer  "updater_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name", "tenant_id"], name: "index_tags_on_name_and_tenant_id", unique: true, using: :btree

  create_table "tags_original", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "tenant_id",   limit: 4
    t.integer  "creator_id",  limit: 4
    t.integer  "updater_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "tags_original", ["name"], name: "name", using: :btree
  add_index "tags_original", ["tenant_id"], name: "tenant_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "subdomain",                    limit: 255
    t.string   "fqdn",                         limit: 255
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.boolean  "new_user_restriction",                       default: false
    t.string   "self_serve_allowed_domain",    limit: 255
    t.string   "safe_domains",                 limit: 255
    t.boolean  "default",                                    default: false
    t.text     "site_title",                   limit: 65535
    t.text     "landing_page",                 limit: 65535
    t.text     "footer",                       limit: 65535
    t.string   "required_github_organization", limit: 255
    t.text     "github_auth_failure_message",  limit: 65535
  end

  add_index "tenants", ["fqdn"], name: "domain", using: :btree
  add_index "tenants", ["subdomain"], name: "subdomain", using: :btree

  create_table "topic_files", force: :cascade do |t|
    t.integer  "topic_id",           limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at",               null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "parent_topic_id",   limit: 4
    t.string   "name",              limit: 255
    t.string   "description",       limit: 255
    t.text     "content",           limit: 65535
    t.integer  "tenant_id",         limit: 4
    t.integer  "creator_id",        limit: 4
    t.integer  "updater_id",        limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "slug",              limit: 255
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at",                                null: false
    t.boolean  "delta",                           default: true, null: false
    t.integer  "lft",               limit: 4
    t.integer  "rgt",               limit: 4
    t.integer  "depth",             limit: 4
    t.integer  "children_count",    limit: 4
    t.integer  "position",          limit: 4
  end

  add_index "topics", ["tenant_id", "depth"], name: "index_topics_on_tenant_id_and_depth", using: :btree
  add_index "topics", ["tenant_id", "lft"], name: "index_topics_on_tenant_id_and_lft", using: :btree
  add_index "topics", ["tenant_id", "parent_topic_id"], name: "index_topics_on_tenant_id_and_parent_topic_id", using: :btree
  add_index "topics", ["tenant_id", "rgt"], name: "index_topics_on_tenant_id_and_rgt", using: :btree
  add_index "topics", ["tenant_id"], name: "tenant_id", using: :btree

  create_table "transcode_remotes", force: :cascade do |t|
    t.integer  "video_asset_id", limit: 4
    t.integer  "job_id",         limit: 4
    t.integer  "status",         limit: 4
    t.text     "response",       limit: 65535
    t.datetime "last_checked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transcode_remotes", ["video_asset_id"], name: "index_transcode_remotes_on_video_asset_id", using: :btree

  create_table "user_notifications", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "notification_id", limit: 4
    t.boolean  "read",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_notifications", ["notification_id"], name: "index_user_notifications_on_notification_id", using: :btree
  add_index "user_notifications", ["user_id", "notification_id"], name: "index_user_notifications_on_user_id_and_notification_id", using: :btree
  add_index "user_notifications", ["user_id"], name: "index_user_notifications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "avatar_url",             limit: 255
    t.boolean  "admin"
    t.integer  "tenant_id",              limit: 4
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at",                             null: false
    t.datetime "remember_created_at",                                null: false
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at",                                 null: false
    t.datetime "last_sign_in_at",                                    null: false
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at",                                       null: false
    t.datetime "confirmation_sent_at",                               null: false
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "approved",                           default: false
    t.boolean  "active",                             default: true
    t.string   "hipchat_mention_name",   limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.boolean  "skip_confirmation",                  default: false
    t.boolean  "skip_activation",                    default: false
  end

  add_index "users", ["approved"], name: "approved", using: :btree

  create_table "version_associations", force: :cascade do |t|
    t.integer "version_id",       limit: 4
    t.string  "foreign_key_name", limit: 255, null: false
    t.integer "foreign_key_id",   limit: 4
  end

  add_index "version_associations", ["foreign_key_name", "foreign_key_id"], name: "index_version_associations_on_foreign_key", using: :btree
  add_index "version_associations", ["version_id"], name: "index_version_associations_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255,      null: false
    t.integer  "item_id",        limit: 4,        null: false
    t.string   "event",          limit: 255,      null: false
    t.string   "whodunnit",      limit: 255
    t.text     "object",         limit: 65535
    t.datetime "created_at",                      null: false
    t.integer  "transaction_id", limit: 4
    t.text     "object_changes", limit: 16777215
  end

  add_index "versions", ["item_type", "item_id"], name: "item_type", using: :btree
  add_index "versions", ["transaction_id"], name: "index_versions_on_transaction_id", using: :btree

  create_table "video_access_secrets", force: :cascade do |t|
    t.integer  "video_asset_id", limit: 4
    t.string   "value",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "video_access_secrets", ["video_asset_id"], name: "index_video_access_secrets_on_video_asset_id", using: :btree

  create_table "video_attachments", force: :cascade do |t|
    t.integer  "tenant_id",          limit: 4
    t.integer  "video_asset_id",     limit: 4
    t.string   "name",               limit: 255
    t.text     "description",        limit: 65535
    t.string   "asset_file_name",    limit: 255
    t.string   "asset_content_type", limit: 255
    t.integer  "asset_file_size",    limit: 4
    t.datetime "asset_updated_at"
    t.integer  "creator_id",         limit: 4
    t.integer  "updater_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", force: :cascade do |t|
    t.string   "visit_token",      limit: 255
    t.string   "visitor_token",    limit: 255
    t.string   "ip",               limit: 255
    t.text     "user_agent",       limit: 65535
    t.text     "referrer",         limit: 65535
    t.text     "landing_page",     limit: 65535
    t.integer  "user_id",          limit: 4
    t.string   "referring_domain", limit: 255
    t.string   "search_keyword",   limit: 255
    t.string   "browser",          limit: 255
    t.string   "os",               limit: 255
    t.string   "device_type",      limit: 255
    t.integer  "screen_height",    limit: 4
    t.integer  "screen_width",     limit: 4
    t.string   "country",          limit: 255
    t.string   "region",           limit: 255
    t.string   "city",             limit: 255
    t.string   "postal_code",      limit: 255
    t.decimal  "latitude",                       precision: 10
    t.decimal  "longitude",                      precision: 10
    t.string   "utm_source",       limit: 255
    t.string   "utm_medium",       limit: 255
    t.string   "utm_term",         limit: 255
    t.string   "utm_content",      limit: 255
    t.string   "utm_campaign",     limit: 255
    t.datetime "started_at"
  end

  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree
  add_index "visits", ["visit_token"], name: "index_visits_on_visit_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
