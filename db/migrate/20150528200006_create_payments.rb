ROM::SQL.migration do
  change do
    create_table :payments do
      primary_key :id
      column :advertisement_id, Integer, null: false
      column :amount_cents, Bignum, null: false
      column :created_at, Time, null: false
    end
    add_index :payments, :advertisement_id
  end
end
