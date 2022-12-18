require 'json'
require './lib/store_receipt_generator/services/item_generator'

class Generator

  READ_FILENAME = 'basket.json'.freeze
  WRITE_FILENAME = 'receipts.txt'.freeze

  def self.generate
    new.generate
  end

  def generate
    populate_basket_items
    File.open(WRITE_FILENAME, "w") do |f| 
      @basket_items.each_pair do |basket_number, items|
        receipt_lines = items.map { |item| "#{item.quantity} #{item.description.gsub(' at', ':')} #{item.total_price}" }
        receipt_total_price = items.map(&:total_price).sum
        receipt_total_tax = items.map(&:tax_amount).sum
        f.write("Output #{basket_number + 1}\n")
        receipt_lines.each { |line| f.write("#{line}\n")}
        f.write("Sales Taxes: #{receipt_total_tax}\n")
        f.write("Total: #{receipt_total_price}\n\n")
      end
    end
  end

  private

  def initialize
    @basket_items = {}
  end

  def populate_basket_items
    data = JSON.parse(JSON.load(File.open(READ_FILENAME)))
    data.map! { |hash_array| hash_array.map { |hash| hash.transform_keys(&:to_sym) } }
    
    data.each_with_index do |basket, index|
      @basket_items[index] = 
        StoreReceiptGenerator::Services::ItemGenerator.new(basket).generate
    end
  end
end

Generator.generate
