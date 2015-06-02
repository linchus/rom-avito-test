class Users < ROM::Relation[:sql]
  one_to_many :advertisements, key: :user_id

  def by_token(token)
    where(access_token: token)
  end

  def by_id(id)
    where(id: id)
  end

  def with_ads
    association_join(:advertisements, select: [:title, :description, :price_cents])
  end
end
