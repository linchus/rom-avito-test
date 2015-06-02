class UpdateAdvertisement < ROM::Commands::Update[:sql]
  register_as :update
  relation :advertisements
  result :one
end
