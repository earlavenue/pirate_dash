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

ActiveRecord::Schema.define(version: 20131017180905) do

  create_table "clients", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "organization_id"
  end

  add_index "clients", ["organization_id"], name: "client_org_id_ix", using: :btree

  create_table "memberships", force: true do |t|
    t.integer "organization_id"
    t.integer "person_id"
    t.date    "first_upload_date"
  end

  add_index "memberships", ["organization_id"], name: "membership_org_id_ix", using: :btree
  add_index "memberships", ["person_id"], name: "membership_person_id_ix", using: :btree

  create_table "of_allowPHP_functions", force: true do |t|
    t.string "name",     limit: 100, null: false
    t.text   "function",             null: false
  end

  create_table "of_commentmeta", primary_key: "meta_id", force: true do |t|
    t.integer "comment_id", limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "of_commentmeta", ["comment_id"], name: "comment_id", using: :btree
  add_index "of_commentmeta", ["meta_key"], name: "meta_key", using: :btree

  create_table "of_comments", primary_key: "comment_ID", force: true do |t|
    t.integer  "comment_post_ID",      limit: 8,   default: 0,   null: false
    t.text     "comment_author",       limit: 255,               null: false
    t.string   "comment_author_email", limit: 100, default: "",  null: false
    t.string   "comment_author_url",   limit: 200, default: "",  null: false
    t.string   "comment_author_IP",    limit: 100, default: "",  null: false
    t.datetime "comment_date",                                   null: false
    t.datetime "comment_date_gmt",                               null: false
    t.text     "comment_content",                                null: false
    t.integer  "comment_karma",                    default: 0,   null: false
    t.string   "comment_approved",     limit: 20,  default: "1", null: false
    t.string   "comment_agent",                    default: "",  null: false
    t.string   "comment_type",         limit: 20,  default: "",  null: false
    t.integer  "comment_parent",       limit: 8,   default: 0,   null: false
    t.integer  "user_id",              limit: 8,   default: 0,   null: false
  end

  add_index "of_comments", ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
  add_index "of_comments", ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
  add_index "of_comments", ["comment_parent"], name: "comment_parent", using: :btree
  add_index "of_comments", ["comment_post_ID"], name: "comment_post_ID", using: :btree

  create_table "of_links", primary_key: "link_id", force: true do |t|
    t.string   "link_url",                          default: "",  null: false
    t.string   "link_name",                         default: "",  null: false
    t.string   "link_image",                        default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description",                  default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.integer  "link_owner",       limit: 8,        default: 1,   null: false
    t.integer  "link_rating",                       default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",                          default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",                          default: "",  null: false
  end

  add_index "of_links", ["link_visible"], name: "link_visible", using: :btree

  create_table "of_of_badge_lib", id: false, force: true do |t|
    t.integer   "id",                 limit: 8, null: false
    t.text      "badge_name"
    t.text      "criteria"
    t.text      "image_loc"
    t.timestamp "date_create",                  null: false
    t.text      "badge_headline"
    t.text      "badge_subhead"
    t.text      "badge_facebook_txt"
    t.text      "badge_twitter_txt"
    t.text      "fb_image_loc"
  end

  add_index "of_of_badge_lib", ["id"], name: "id", unique: true, using: :btree

  create_table "of_of_goal_lib", id: false, force: true do |t|
    t.integer   "id",           limit: 8, null: false
    t.text      "goal_name"
    t.text      "goal_type"
    t.text      "units"
    t.float     "default_goal"
    t.integer   "timeframe"
    t.timestamp "date_create",            null: false
    t.text      "metric_units"
  end

  add_index "of_of_goal_lib", ["id"], name: "id", unique: true, using: :btree

  create_table "of_of_measurements", id: false, force: true do |t|
    t.integer   "id",                    limit: 8,                null: false
    t.integer   "user_id",               limit: 8,                null: false
    t.datetime  "date",                                           null: false
    t.integer   "total_steps",                                    null: false
    t.integer   "aerobic_steps",                      default: 0, null: false
    t.integer   "aerobic_walking_time"
    t.integer   "calories"
    t.float     "distance"
    t.float     "fat_burned"
    t.text      "hourly_steps"
    t.text      "hourly_aerobic_steps"
    t.text      "hourly_equip"
    t.text      "hourly_event"
    t.integer   "is_device_input",       limit: 1,                null: false
    t.integer   "day_serial"
    t.timestamp "server_time",                                    null: false
    t.text      "device_serial"
    t.float     "weight"
    t.string    "clientversion",         limit: 10
    t.string    "platform",              limit: 10
    t.integer   "hrm_duration"
    t.integer   "hrm_max_hr"
    t.integer   "hrm_avg_hr"
    t.string    "hrm_status",            limit: 512
    t.string    "hrm_distance_readings", limit: 512
    t.string    "hrm_hr_readings",       limit: 1024
    t.float     "walkMass"
    t.float     "aerobicMass"
    t.integer   "aerobicCalories"
    t.integer   "basalMetabolism"
    t.integer   "walkCalories"
    t.string    "device_model"
  end

  add_index "of_of_measurements", ["date", "device_serial", "user_id"], name: "unique_measure", unique: true, length: {"date"=>nil, "device_serial"=>20, "user_id"=>nil}, using: :btree
  add_index "of_of_measurements", ["id"], name: "id", unique: true, using: :btree
  add_index "of_of_measurements", ["user_id"], name: "user_id", using: :btree

  create_table "of_of_oauth_consumer", force: true do |t|
    t.string    "consumer_key",    limit: 100, null: false
    t.string    "consumer_secret", limit: 100, null: false
    t.string    "url",             limit: 200, null: false
    t.timestamp "created_on",                  null: false
    t.string    "company",         limit: 100, null: false
  end

  create_table "of_of_oauth_request", force: true do |t|
    t.integer   "user_id",        limit: 3
    t.string    "request_key",    limit: 100, null: false
    t.string    "request_secret", limit: 100, null: false
    t.timestamp "created_on",                 null: false
  end

  add_index "of_of_oauth_request", ["request_key"], name: "request_key", using: :btree

  create_table "of_of_oauth_user", force: true do |t|
    t.integer   "user_id",                   null: false
    t.string    "access_key",    limit: 100, null: false
    t.string    "access_secret", limit: 100, null: false
    t.string    "partner_id",    limit: 100, null: false
    t.timestamp "created_on",                null: false
  end

  create_table "of_of_product_reg", force: true do |t|
    t.string    "first_name",    limit: 50
    t.string    "last_name",     limit: 50
    t.string    "email",         limit: 100
    t.string    "address1",      limit: 100
    t.string    "address2",      limit: 50
    t.string    "country",       limit: 15
    t.string    "state",         limit: 15
    t.string    "city",          limit: 15
    t.string    "zip",           limit: 15
    t.string    "prod_category", limit: 15,  null: false
    t.string    "model_num",     limit: 15,  null: false
    t.string    "serial_num",    limit: 15,  null: false
    t.string    "date",          limit: 15,  null: false
    t.string    "price",         limit: 15,  null: false
    t.string    "location",      limit: 15,  null: false
    t.string    "client_type",   limit: 50,  null: false
    t.timestamp "register_time",             null: false
  end

  create_table "of_of_sharing", id: false, force: true do |t|
    t.integer "id",                  limit: 8,               null: false
    t.integer "user_id",             limit: 8,               null: false
    t.integer "fb_id",               limit: 8
    t.integer "twt_id",              limit: 8
    t.text    "email_id"
    t.integer "total_week_steps",    limit: 8, default: 0
    t.float   "total_week_distance",           default: 0.0
    t.integer "total_week_calories",           default: 0
  end

  add_index "of_of_sharing", ["fb_id"], name: "fb_id", unique: true, using: :btree
  add_index "of_of_sharing", ["id"], name: "id", unique: true, using: :btree

  create_table "of_of_user_badges", id: false, force: true do |t|
    t.integer   "id",           limit: 8, null: false
    t.integer   "badge_id",     limit: 8, null: false
    t.integer   "user_id",      limit: 8, null: false
    t.timestamp "date_awarded",           null: false
  end

  add_index "of_of_user_badges", ["id"], name: "id", unique: true, using: :btree
  add_index "of_of_user_badges", ["user_id"], name: "user_id", using: :btree

  create_table "of_of_user_goals", id: false, force: true do |t|
    t.integer   "id",              limit: 8,               null: false
    t.integer   "user_id",         limit: 8,               null: false
    t.integer   "goal_id",         limit: 8,               null: false
    t.text      "goal_type"
    t.float     "value",                     default: 0.0
    t.float     "progress",                  default: 0.0
    t.integer   "timeframe"
    t.timestamp "date_start_goal",                         null: false
  end

  add_index "of_of_user_goals", ["id"], name: "id", unique: true, using: :btree
  add_index "of_of_user_goals", ["user_id", "goal_id"], name: "user_goal", unique: true, using: :btree
  add_index "of_of_user_goals", ["user_id"], name: "user_id", using: :btree

  create_table "of_of_users", id: false, force: true do |t|
    t.integer   "user_id",                limit: 8,                      null: false
    t.text      "first_name",             limit: 255,                    null: false
    t.text      "last_name",              limit: 255,                    null: false
    t.text      "email",                  limit: 255,                    null: false
    t.text      "password",               limit: 255,                    null: false
    t.datetime  "birthdate"
    t.text      "gender",                 limit: 255
    t.text      "country",                limit: 255
    t.text      "address1",               limit: 255
    t.text      "address2",               limit: 255
    t.text      "city",                   limit: 255
    t.text      "state",                  limit: 255
    t.text      "zip",                    limit: 255
    t.text      "phone",                  limit: 255
    t.text      "timezone",               limit: 255
    t.binary    "profile_pic",            limit: 2147483647
    t.string    "ext",                    limit: 5
    t.integer   "email_comm",                                default: 1
    t.integer   "display_weight",                            default: 1
    t.integer   "private_profile",                           default: 0
    t.integer   "imperial_units",                            default: 1
    t.text      "twitter_token"
    t.text      "twitter_verifier"
    t.integer   "twitter_user_id",        limit: 8
    t.integer   "facebook_user_id",       limit: 8
    t.integer   "best_step_day",                             default: 0
    t.datetime  "best_step_day_date"
    t.integer   "best_calories_day",                         default: 0
    t.datetime  "best_calories_day_date"
    t.float     "best_distance_day"
    t.datetime  "best_distance_day_date"
    t.timestamp "date_created",                                          null: false
    t.integer   "new_user",                                  default: 1
    t.datetime  "last_visit_time"
    t.string    "pw_reset",               limit: 12,                     null: false
    t.datetime  "last_upload",                                           null: false
    t.string    "runkeeper_token",        limit: 32
    t.integer   "beta",                   limit: 1,          default: 0, null: false
    t.string    "hv_record_id",           limit: 40
    t.string    "hv_person_id",           limit: 40
  end

  add_index "of_of_users", ["facebook_user_id"], name: "facebook_user_id", unique: true, using: :btree
  add_index "of_of_users", ["twitter_user_id"], name: "twitter_user_id", unique: true, using: :btree
  add_index "of_of_users", ["user_id"], name: "id", unique: true, using: :btree

  create_table "of_of_weekly_measurements", force: true do |t|
    t.datetime  "start_date",                     null: false
    t.integer   "additional_calories",            null: false
    t.timestamp "server_time",                    null: false
    t.integer   "user_id",                        null: false
    t.integer   "weekly_target",                  null: false
    t.string    "device_serial",       limit: 40
  end

  create_table "of_of_workout", force: true do |t|
    t.integer   "user_id",                   null: false
    t.timestamp "server_time",               null: false
    t.string    "device_serial", limit: 50,  null: false
    t.integer   "walkStep",                  null: false
    t.integer   "calories",                  null: false
    t.float     "fatBurned",                 null: false
    t.integer   "walkTime",                  null: false
    t.datetime  "endDate",                   null: false
    t.datetime  "startDate",                 null: false
    t.float     "totalDistance",             null: false
    t.float     "averageSpeed",              null: false
    t.float     "averagePace",               null: false
    t.integer   "jogTime",                   null: false
    t.integer   "jogStep",                   null: false
    t.string    "distance",      limit: 100, null: false
    t.string    "status",        limit: 100, null: false
  end

  create_table "of_options", primary_key: "option_id", force: true do |t|
    t.string "option_name",  limit: 64,         default: "",    null: false
    t.text   "option_value", limit: 2147483647,                 null: false
    t.string "autoload",     limit: 20,         default: "yes", null: false
  end

  add_index "of_options", ["option_name"], name: "option_name", unique: true, using: :btree

  create_table "of_postmeta", primary_key: "meta_id", force: true do |t|
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "of_postmeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "of_postmeta", ["post_id"], name: "post_id", using: :btree

  create_table "of_posts", primary_key: "ID", force: true do |t|
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 2147483647,                     null: false
    t.text     "post_title",                                                   null: false
    t.text     "post_excerpt",                                                 null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",                                                      null: false
    t.text     "pinged",                                                       null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered", limit: 2147483647,                     null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                                     default: "",        null: false
    t.integer  "menu_order",                               default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
  end

  add_index "of_posts", ["post_author"], name: "post_author", using: :btree
  add_index "of_posts", ["post_name"], name: "post_name", using: :btree
  add_index "of_posts", ["post_parent"], name: "post_parent", using: :btree
  add_index "of_posts", ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree

  create_table "of_rg_form", force: true do |t|
    t.string   "title",        limit: 150,                null: false
    t.datetime "date_created",                            null: false
    t.boolean  "is_active",                default: true, null: false
  end

  create_table "of_rg_form_meta", primary_key: "form_id", force: true do |t|
    t.text "display_meta",      limit: 2147483647
    t.text "entries_grid_meta", limit: 2147483647
  end

  create_table "of_rg_form_view", force: true do |t|
    t.integer  "form_id",      limit: 3,              null: false
    t.datetime "date_created",                        null: false
    t.string   "ip",           limit: 15
    t.integer  "count",        limit: 3,  default: 1, null: false
  end

  add_index "of_rg_form_view", ["form_id"], name: "form_id", using: :btree

  create_table "of_rg_lead", force: true do |t|
    t.integer  "form_id",          limit: 3,                                               null: false
    t.integer  "post_id",          limit: 8
    t.datetime "date_created",                                                             null: false
    t.boolean  "is_starred",                                            default: false,    null: false
    t.boolean  "is_read",                                               default: false,    null: false
    t.string   "ip",               limit: 39,                                              null: false
    t.string   "source_url",       limit: 200,                          default: "",       null: false
    t.string   "user_agent",       limit: 250,                          default: "",       null: false
    t.string   "currency",         limit: 5
    t.string   "payment_status",   limit: 15
    t.datetime "payment_date"
    t.decimal  "payment_amount",               precision: 19, scale: 2
    t.string   "transaction_id",   limit: 50
    t.boolean  "is_fulfilled"
    t.integer  "created_by",       limit: 8
    t.boolean  "transaction_type"
    t.string   "status",           limit: 20,                           default: "active", null: false
  end

  add_index "of_rg_lead", ["form_id"], name: "form_id", using: :btree
  add_index "of_rg_lead", ["status"], name: "status", using: :btree

  create_table "of_rg_lead_detail", force: true do |t|
    t.integer "lead_id",                  null: false
    t.integer "form_id",      limit: 3,   null: false
    t.float   "field_number",             null: false
    t.string  "value",        limit: 200
  end

  add_index "of_rg_lead_detail", ["form_id"], name: "form_id", using: :btree
  add_index "of_rg_lead_detail", ["lead_id"], name: "lead_id", using: :btree

  create_table "of_rg_lead_detail_long", primary_key: "lead_detail_id", force: true do |t|
    t.text "value", limit: 2147483647
  end

  create_table "of_rg_lead_meta", force: true do |t|
    t.integer "lead_id",    limit: 8,          null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "of_rg_lead_meta", ["lead_id"], name: "lead_id", using: :btree
  add_index "of_rg_lead_meta", ["meta_key"], name: "meta_key", using: :btree

  create_table "of_rg_lead_notes", force: true do |t|
    t.integer  "lead_id",                         null: false
    t.string   "user_name",    limit: 250
    t.integer  "user_id",      limit: 8
    t.datetime "date_created",                    null: false
    t.text     "value",        limit: 2147483647
  end

  add_index "of_rg_lead_notes", ["lead_id", "user_id"], name: "lead_user_key", using: :btree
  add_index "of_rg_lead_notes", ["lead_id"], name: "lead_id", using: :btree

  create_table "of_rg_mailchimp", force: true do |t|
    t.integer "form_id",   limit: 3,                         null: false
    t.boolean "is_active",                    default: true, null: false
    t.text    "meta",      limit: 2147483647
  end

  add_index "of_rg_mailchimp", ["form_id"], name: "form_id", using: :btree

  create_table "of_term_relationships", id: false, force: true do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "term_order",                 default: 0, null: false
  end

  add_index "of_term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "of_term_taxonomy", primary_key: "term_taxonomy_id", force: true do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "of_term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "of_term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "of_terms", primary_key: "term_id", force: true do |t|
    t.string  "name",       limit: 200, default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "of_terms", ["name"], name: "name", using: :btree
  add_index "of_terms", ["slug"], name: "slug", unique: true, using: :btree

  create_table "of_usermeta", primary_key: "umeta_id", force: true do |t|
    t.integer "user_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "of_usermeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "of_usermeta", ["user_id"], name: "user_id", using: :btree

  create_table "of_users", primary_key: "ID", force: true do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 64,  default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 60,  default: "", null: false
    t.integer  "user_status",                     default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
  end

  add_index "of_users", ["user_login"], name: "user_login_key", using: :btree
  add_index "of_users", ["user_nicename"], name: "user_nicename", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "quarter_summaries", force: true do |t|
    t.string  "device_model"
    t.integer "activations"
    t.date    "start_date"
  end

  create_table "quarters", force: true do |t|
    t.string  "person_id"
    t.date    "start_date"
    t.boolean "active"
  end

end
