class CreateAdvertisement < ROM::Commands::Create[:sql]
  register_as :create
  relation :advertisements
  result :one
end
