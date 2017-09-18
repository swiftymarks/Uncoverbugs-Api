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

ActiveRecord::Schema.define(version: 20170829073720) do

  create_table "brands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "company_name"
    t.string "company_url"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "brand"
    t.string "model"
    t.string "browser"
    t.string "platform"
    t.string "operating_system"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices_test_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "test_plan_id"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_devices_test_plans_on_device_id"
    t.index ["test_plan_id"], name: "index_devices_test_plans_on_test_plan_id"
  end

  create_table "notification_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean "newsletter", default: true
    t.boolean "notify_new_project", default: true
    t.boolean "notify_work_evaluation", default: true
    t.boolean "notify_events", default: true
    t.bigint "tester_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tester_id"], name: "index_notification_settings_on_tester_id"
  end

  create_table "operating_systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "platforms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_modules_on_project_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.integer "testing_type"
    t.string "version"
    t.string "testing_site"
    t.text "objective"
    t.integer "language"
    t.string "result_email"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
  end

  create_table "test_plan_project_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "test_plans_id"
    t.bigint "project_modules_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_modules_id"], name: "index_test_plan_project_modules_on_project_modules_id"
    t.index ["test_plans_id"], name: "index_test_plan_project_modules_on_test_plans_id"
  end

  create_table "test_plans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "testing_url"
    t.text "step_explanation"
    t.string "name"
    t.integer "minimum_time"
    t.boolean "is_fix"
    t.integer "testing_type"
    t.string "script_file"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_test_plans_on_project_id"
  end

  create_table "tester_devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tester_id"
    t.bigint "device_id"
    t.index ["device_id"], name: "index_tester_devices_on_device_id"
    t.index ["tester_id"], name: "index_tester_devices_on_tester_id"
  end

  create_table "testers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "address1"
    t.text "address2"
    t.string "province"
    t.string "skype_id"
    t.integer "zip_code"
    t.string "mobile_number"
    t.integer "gender"
    t.integer "born_year"
    t.string "paypal_email"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_testers_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "user_type"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
