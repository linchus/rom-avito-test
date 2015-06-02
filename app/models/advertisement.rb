class Advertisement
  include Virtus.model

  attribute :id, Integer
  attribute :title, String
  attribute :description, String
  attribute :paid_until, Date
  attribute :user_id, Integer
  attribute :category, String
  attribute :is_active, Boolean

  CATEGORIES = %w(auto gadgets food)
  FEE = 100

  def can_edit?(user)
    user_id == user.id
  end

  def deactivate!
    self.is_active = false
  end

  def add_payment(payment_amount)
    self.paid_until = calc_paid_date(payment_amount)
  end

  private

  def calc_paid_date(payment_amount)
    paid_days = (payment_amount / FEE).days
    if paid_until && paid_until > Date.today
      paid_until + paid_days
    else
      Date.today + paid_days
    end
  end
end
