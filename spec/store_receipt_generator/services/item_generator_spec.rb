require 'store_receipt_generator/services/item_generator'
require 'store_receipt_generator/services/tax_calculator'

describe StoreReceiptGenerator::Services::ItemGenerator do
  describe '#calculate' do
    let(:tax_rate)    { 0.05 }
    let(:tax_amount)  { 1.75 }
    let(:item_hash_array)  { [item_hash_1, item_hash_2] }
    let(:item_hash_1) do
      {
        quantity: 1,
        description: 'imported box of chocolates at',
        price:  10.00
      }
    end
    let(:item_hash_2) do
      {
        quantity: 1,
        description: 'imported bottle of perfume at',
        price:  47.50
      }
    end

    let(:tax_calculator) { double(StoreReceiptGenerator::Services::TaxCalculator, calculate: [tax_rate, tax_amount]) }
    let(:item_generator) { described_class.new(item_hash_array) }

    before do
      allow(StoreReceiptGenerator::Services::TaxCalculator)
        .to receive(:new) { tax_calculator }
    end

    it 'generates StoreReceiptGenerator::Models::Item instances' do
      expect(item_generator.generate.first).to be_a(StoreReceiptGenerator::Models::Item)
    end

    it 'generates items with the correct values' do
      generated_item = item_generator.generate.first
      expect(generated_item.quantity).to eq(item_hash_1[:quantity])
      expect(generated_item.description).to eq(item_hash_1[:description])
      expect(generated_item.price).to eq(item_hash_1[:price])
      expect(generated_item.tax_rate).to eq(tax_rate)
      expect(generated_item.tax_amount).to eq(tax_amount)
    end
  end
end
