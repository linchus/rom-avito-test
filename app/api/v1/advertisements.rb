module Avito
  module API
    module V1
      class Advertisements < Grape::API
        resource :advertisements do
          get '/', jbuilder: 'advertisements/index', skip_auth: true do
            @ads = rom.relations.advertisements.filter(params).to_a
          end

          params do
            requires :title, type: String
            requires :category, values: Advertisement::CATEGORIES
            requires :price_cents, type: Integer
          end
          post '/', jbuilder: 'advertisements/show' do
            @ad = rom.command(:advertisements).create.call params.merge(user_id: current_user.id)
          end

          post '/:id/deactivate' do
            @ad = rom.relation(:advertisements).by_id(params[:id]).as(:advertisement).one!
            fail User::Forbidden unless @ad.can_edit?(current_user)
            @ad.deactivate!
            rom.command(:advertisements).update.by_id(@ad.id).call @ad
            status 202
          end
        end
      end
    end
  end
end
