ActiveRecord::Schema[7.1].define(version: 2026_09_01_000000) do
  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.string "customer_email"
    t.string "customer_phone"
    t.string "shipping_address"
    t.integer "total_cents"
    t.string "status"
    t.timestamps
  end
end
