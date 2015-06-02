class UserMapper < ROM::Mapper
  relation :users
  register_as :user

  model User

  attribute :id
  attribute :name
  attribute :access_token

  group advertisements: [:title, :description, :price_cents]
end
