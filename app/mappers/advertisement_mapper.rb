require 'mappers/user_mapper'
class AdvertisementMapper < ROM::Mapper
  relation :advertisements
  register_as :advertisement
  model Advertisement

  attribute :title
  attribute :description
  attribute :price_cents
  attribute :category
end
