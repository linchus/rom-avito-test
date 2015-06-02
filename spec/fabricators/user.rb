class TestUser < Sequel::Model(:users); end

Fabricator(:user, from: :test_user) do
  name { sequence(:name) { |i| "User name #{i}" } }
  access_token { SecureRandom.uuid }
end
