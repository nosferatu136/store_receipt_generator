
require './lib/store_receipt_generator/models/item'
require './lib/store_receipt_generator/services/tax_calculator'

module StoreReceiptGenerator
  module Services
    class ItemGenerator
      def generate
        complete_item_hashes.map { |item_hash| Models::Item.new(item_hash) }
      end

      private

      def initialize(item_hash_array)
        @item_hash_array = item_hash_array
      end

      def complete_item_hashes
        @item_hash_array.map do |item_hash|
          item_hash[:tax_rate], item_hash[:tax_amount] = 
            Services::TaxCalculator.new(item_hash[:price], item_hash[:description]).calculate
          item_hash
        end
      end
    end
  end
end
