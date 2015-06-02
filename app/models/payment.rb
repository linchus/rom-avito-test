class Payment
  include Virtus.model

  attribute :id, Integer
  attribute :advertisement_id, Integer
  attribute :amount_cents, Integer
end
