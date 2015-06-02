require 'spec/rack_helper'

describe Avito::API::V1::Users, type: :controller do
  let(:user) { Fabricate :user }

  describe 'GET /v1/advertisements' do
    shared_examples 'correct response' do
      it { is_expected.to be_ok }
      it { is_expected.to match_response_schema('ads/list') }
    end

    shared_examples 'successful search' do
      it 'returns sought-for ads' do
        subject
        expect(json_response.length).to eq objects.length
        expect(json_response.map { |item| item['id'] }).to eq objects.map(&:id)
      end
    end

    let!(:ads) { Fabricate.times(2, :paid_advertisement, price_cents: 0) }
    let!(:inactive_ad) { Fabricate :paid_advertisement, is_active: false }
    let!(:unpaid_ad) { Fabricate :advertisement }
    subject {  get '/api/v1/advertisements', params }

    context 'without filter' do
      let(:params) { {} }
      it_behaves_like 'correct response'
      it_behaves_like 'successful search' do
        let(:objects) { ads }
      end
    end

    context 'with title filter' do
      let(:title) { 'beer' }
      let(:params) { { title: title } }
      let!(:target_ad) { Fabricate(:paid_advertisement, title: title) }
      it_behaves_like 'correct response'
      it_behaves_like 'successful search' do
        let(:objects) { [target_ad] }
      end
    end

    context 'with category filter' do
      let(:category) { 'beer' }
      let(:params) { { category: category } }
      let!(:target_ad) { Fabricate(:paid_advertisement, category: category) }
      it_behaves_like 'correct response'
      it_behaves_like 'successful search' do
        let(:objects) { [target_ad] }
      end
    end

    context 'with price filter' do
      let(:params) { { price: prices } }
      let!(:ad_left) { Fabricate(:paid_advertisement, price_cents: 1000) }
      let!(:ad_middle) { Fabricate(:paid_advertisement, price_cents: 2000) }
      let!(:ad_right) { Fabricate(:paid_advertisement, price_cents: 3000) }
      context 'with left limit' do
        let(:prices) { { from: 1500, to: nil } }
        it_behaves_like 'correct response'
        it_behaves_like 'successful search' do
          let(:objects) { [ad_middle, ad_right] }
        end
      end

      context 'with right limit' do
        let(:prices) { { from: nil, to: 2500 } }
        it_behaves_like 'correct response'
        it_behaves_like 'successful search' do
          let(:objects) { ads + [ad_left, ad_middle] }
        end
      end

      context 'with left and right limits' do
        let(:prices) { { from: 1500, to: 2500 } }
        it_behaves_like 'correct response'
        it_behaves_like 'successful search' do
          let(:objects) { [ad_middle] }
        end
      end
    end
  end

  describe 'POST /v1/advertisements' do
    let(:params) { {} }
    subject {  post '/api/v1/advertisements', params }
    context 'with authenticated user' do
      login_user
      context 'with correct params' do
        let(:params) do
          {
            title: 'Ad title',
            description: 'Ad desc',
            price_cents: 1000,
            category: Advertisement::CATEGORIES.sample,
            contact: '123'
          }
        end
        it { is_expected.to be_created }
        it 'create new ad' do
          expect { subject }.to change { rom.relations.advertisements.count }.by(1)
        end
      end

      context 'with invalid params' do
        let(:params) { {} }
        it { is_expected.to be_unprocessable }
      end
    end

    context 'without authenticated user' do
      it_behaves_like 'unauthorized request'
    end
  end

  describe 'POST /v1/advertisements/:id/deactivate' do
    let(:ad) { Fabricate :advertisement }
    let(:user) { rom.relation(:users).by_id(ad.user_id).as(:user).one! }
    subject {  post "/api/v1/advertisements/#{ad.id}/deactivate" }
    context 'with authenticated user' do
      context 'who can edit ad' do
        before do
          authenticate_user(user)
        end

        it { is_expected.to be_accepted }
        it 'set is_active to false' do
          expect { subject }.to change { ad.reload.is_active }.from(true).to(false)
        end
      end

      context 'who can not edit ad' do
        login_user
        it { is_expected.to be_forbidden }
      end
    end

    context 'without authenticated user' do
      it_behaves_like 'unauthorized request'
    end
  end
end
