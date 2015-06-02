ROM::SQL.migration do
  change do
    create_table :users do
      primary_key :id
      column :name, String, null: false
      column :access_token, String, null: false
    end
    add_index :users, :access_token, unique: true
  end
end
