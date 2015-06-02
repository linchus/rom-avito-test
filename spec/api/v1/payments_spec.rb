require 'spec/rack_helper'

describe Avito::API::V1::Payments, type: :controller do
  describe 'POST /v1/payments' do
    let(:params) { {} }
    let(:ad) { Fabricate :advertisement }
    subject { post '/api/v1/payments', params }
    context 'with authenticated user' do
      login_user
      context 'with valid params' do
        let(:params) do
          {
            advertisement_id: ad.id,
            amount_cents: 10 * Advertisement::FEE
          }
        end

        it { is_expected.to be_created }
        it 'create new payment' do
          expect { subject }.to change { rom.relations.payments.count }.by(1)
        end

        it 'update paid_date' do
          expect { subject }.to change { ad.reload.paid_until }.to(Date.today + 10.days)
        end
      end
    end

    context 'without authenticated user' do
      it_behaves_like 'unauthorized request'
    end
  end
end
