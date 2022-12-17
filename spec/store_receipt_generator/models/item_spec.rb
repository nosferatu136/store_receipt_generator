require 'store_receipt_generator/models/item'

describe StoreReceiptGenerator::Models::Item do
  let(:subject)        { described_class.new(item_hash) }
  let(:price)       { 14.99 }
  let(:tax_rate)    { 0.1 }
  let(:tax_amount)  { 1.50 }
  let(:quantity)    { 2 }
  let(:description) { 'music CD at' }
  let(:item_hash) do 
    { 
      quantity: quantity,
      description: description,
      price: price,
      tax_rate: tax_rate,
      tax_amount: tax_amount 
    } 
  end

  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:tax_rate) }
  it { is_expected.to respond_to(:tax_amount) }


  describe '#total_price' do

    it 'returns the sum of price and tax, multiplied by quantity' do
      expect(subject.total_price).to eq (quantity * (price + tax_amount)).round(2)
    end
  end
end
