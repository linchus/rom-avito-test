class CreatePayments < ROM::Commands::Create[:sql]
  register_as :create
  relation :payments
  result :one

  def call(payment_params)
    payment = nil
    transaction do
      advertisement = get_ad(payment_params[:advertisement_id])
      payment = super(payment_params.merge(created_at: Time.now))
      advertisement.add_payment(payment[:amount_cents])
      ROM.env.command(:advertisements).update.by_id(advertisement.id).call advertisement
    end
    payment
  end

  private

  def get_ad(id)
    ROM.env.relation(:advertisements).by_id(id).as(:advertisement).one!
  end
end
