module Avito
  module API
    module V1
      class Users < Grape::API
        resource :users do
          get '/:id', jbuilder: 'users/show' do
            @user = rom.relation(:users).by_id(params[:id]).one!
          end
        end
      end
    end
  end
end
