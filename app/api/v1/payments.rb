module Avito
  module API
    module V1
      class Payments < Grape::API
        resource :payments do
          params do
            requires :advertisement_id, type: Integer
            requires :amount_cents, type: Integer
          end
          post '/', jbuilder: 'payments/show' do
            @payment = rom.command(:payments).create.call params
          end
        end
      end
    end
  end
end
