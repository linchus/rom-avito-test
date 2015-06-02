describe Advertisement do
  describe '.add_payment' do
    let(:payment_amount) { 10 * Advertisement::FEE }
    subject { ad.add_payment(payment_amount) }

    context 'without paid date' do
      let(:ad) { described_class.new Fabricate.attributes_for(:advertisement) }

      it 'set paid date from today' do
        expect { subject }.to change { ad.paid_until }.to(Date.today + 10.days)
      end
    end

    context 'with overdue paid date' do
      let(:ad) { described_class.new Fabricate.attributes_for(:overdue_advertisement) }
      let(:payment_amount) { 10 * Advertisement::FEE }
      it 'set paid date from today' do
        expect { subject }.to change { ad.paid_until }.to(Date.today + 10.days)
      end
    end

    context 'with paid date in future' do
      let(:ad) { described_class.new Fabricate.attributes_for(:paid_advertisement) }
      let(:payment_amount) { 10 * Advertisement::FEE }
      it 'set paid date from last paid day' do
        paid_date = ad.paid_until
        expect { subject }.to change { ad.paid_until }.to(paid_date + 10.days)
      end
    end
  end
end
