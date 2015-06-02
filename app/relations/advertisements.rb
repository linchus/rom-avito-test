class Advertisements < ROM::Relation[:sql]
  many_to_one :users, key: :user_id

  def filter(query)
    scope = active.paid
    scope = scope.with_title_like(query[:title]) if query[:title].present?
    scope = scope.with_category(query[:category]) if query[:category].present?
    scope = scope.with_price(query[:price]) if query[:price].present?
    scope
  end

  def active
    where(is_active: true)
  end

  def with_title_like(title)
    where('title LIKE ?', "%#{title}")
  end

  def with_category(category)
    where(category: category)
  end

  def with_price(price_range)
    scope = self
    scope = scope.where('price_cents >= ?', price_range[:from]) if price_range[:from].present?
    scope = scope.where('price_cents <= ?', price_range[:to]) if price_range[:to].present?
    scope
  end

  def by_id(id)
    where(id: id)
  end

  def paid
    where('paid_until > ?', Date.today)
  end
end
