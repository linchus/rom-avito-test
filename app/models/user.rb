require 'app/models/advertisement'

class User
  class Unauthorized < StandardError; end
  class Forbidden < StandardError; end

  include Virtus.model

  attribute :id, Integer
  attribute :name, String
  attribute :access_token, String
end
