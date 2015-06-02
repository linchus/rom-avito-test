module Avito
  module Helpers
    module Auth
      def signed_in?
        current_user.present?
      end

      def current_user
        @user ||= rom.relation(:users).by_token(request.env['HTTP_X_TOKEN']).as(:user).first
      end

      def authenticate!
        fail User::Unauthorized unless current_user
      end

      def rom
        Application.config.rom
      end
    end
  end
end
