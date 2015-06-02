class TestAd < Sequel::Model(:advertisements); end

Fabricator(:advertisement, from: :test_ad) do
  title { sequence(:title) { |i| "Ad title #{i}" } }
  user_id { Fabricate(:user).id }
  category { Advertisement::CATEGORIES.sample }
end

Fabricator(:paid_advertisement, from: :advertisement) do
  paid_until { Date.tomorrow }
end

Fabricator(:overdue_advertisement, from: :advertisement) do
  paid_until { Date.yesterday }
end
