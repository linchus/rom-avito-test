module AuthenticationHelpers
  extend ActiveSupport::Concern

  included do
    def self.login_user(user_factory: :user)
      before do
        user = Fabricate(user_factory)
        authenticate_user(user)
      end
    end
  end

  def authenticate_user(user)
    header('X-Token', user.access_token)
  end

  def current_user
    ROM.env.relation(:users).by_token(last_request.env['HTTP_X_TOKEN']).as(:entity).first if last_request
  end
end
