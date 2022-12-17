require 'store_receipt_generator/services/tax_calculator'

describe StoreReceiptGenerator::Services::TaxCalculator do
  describe '#calculate' do
    let(:price)     { 14.99 }
    let(:calculator) { described_class.new(price, description) }

    # only testing tax_rate value; tax_amount will be tested in 
    # StoreReceiptGenerator::Services::TaxCalculator::DecimalRounder
    before do
      allow(StoreReceiptGenerator::Services::TaxCalculator::DecimalRounder)
        .to receive(:round) { 1.5 }
    end

    shared_examples 'a calculator that returns the correct tax rate' do
      it 'returns the correct tax rate' do
        tax_rate, _ = calculator.calculate
        expect(tax_rate).to eq expected_tax_rate
      end
    end    
    
    context 'when price applies for sales tax' do
      let(:description)       { 'music CD at' }
      let(:expected_tax_rate) { 0.1 }

      it_behaves_like 'a calculator that returns the correct tax rate'
    end

    context 'when price applies for both sales and import tax' do
      let(:description)       { 'imported music CD at' }
      let(:expected_tax_rate) { 0.15 }

      it_behaves_like 'a calculator that returns the correct tax rate'
    end
    context 'when price applies for import but no sales tax' do
      let(:description)       { 'imported packet of headache pills at' }
      let(:expected_tax_rate) { 0.05 }

      it_behaves_like 'a calculator that returns the correct tax rate'
    end
    
    context 'when price applies for no tax' do
      let(:description)       { 'packet of headache pills at' }
      let(:expected_tax_rate) { 0.0 }

      it_behaves_like 'a calculator that returns the correct tax rate'
    end
  end
end

describe StoreReceiptGenerator::Services::TaxCalculator::DecimalRounder do
  describe '#round' do
    let(:rounder) { described_class.new(initial_amount) }

    context 'when initial value is close to the next dollar' do
      let(:initial_amount) { 0.98 }

      it 'rounds to the next dollar' do
        expect(rounder.round).to eq 1.0
      end
    end

    # rounds decimals up to their next 0.05 value

    [
      { initial_amount: 0.21, expected_amonunt: 0.25 },
      { initial_amount: 0.28, expected_amonunt: 0.30 }
    ].each do |test_values|
      context "when initial amount is #{test_values[:initial_amount]}" do
        let(:initial_amount) { test_values[:initial_amount] }

        it "rounds to #{test_values[:expected_amonunt]}" do
          expect(rounder.round).to eq test_values[:expected_amonunt]
        end
      end
    end

    [
      { initial_amount: 0.25, expected_amonunt: 0.25 },
      { initial_amount: 0.30, expected_amonunt: 0.30 }
    ].each do |test_values|
      context 'when initial amount is a multiple of 0.05' do
        let(:initial_amount) { test_values[:initial_amount] }

        it 'returns it as is' do
          expect(rounder.round).to eq test_values[:expected_amonunt]
        end
      end
    end
  end
end