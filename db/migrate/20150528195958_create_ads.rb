ROM::SQL.migration do
  change do
    create_table :advertisements do
      primary_key :id
      column :user_id, Integer, null: false
      column :title, String, null: false
      column :category, String, null: false
      column :description, String, text: true
      column :price_cents, Bignum, null: false, default: 0
      column :contact, String
      column :paid_until, Date
      column :is_active, TrueClass, null: false, default: true
    end
    add_index :advertisements, :user_id
    add_index :advertisements, :price_cents
    add_index :advertisements, :category
    add_index :advertisements, :is_active
  end
end
