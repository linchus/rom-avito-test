require 'spec/rack_helper'

describe Avito::API::V1::Users, type: :controller do
  let(:user) { Fabricate :user }
  describe 'GET /v1/users/:id' do
    subject {  get "/api/v1/users/#{user.id}" }

    context 'with authenticated user' do
      login_user
      it { is_expected.to be_ok }
      it { is_expected.to match_response_schema('user') }
    end

    context 'without authenticated user' do
      it_behaves_like 'unauthorized request'
    end
  end
end
