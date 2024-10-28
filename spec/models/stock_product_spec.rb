require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      u = User.create!(name: 'Marcos', email: 'marcos@unit.com', password: '123456')
      w = Warehouse.create!(
        name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
        address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
      s = Supplier.create!(
        corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
        full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
      o = Order.create!(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
      p = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 75, depth: 80, sku: 'CGMER-XPTO-888', supplier: s)

      stock_product = StockProduct.create!(order: o, warehouse: w, product_model: p)

      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      u = User.create!(name: 'Marcos', email: 'marcos@unit.com', password: '123456')
      w = Warehouse.create!(
        name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
        address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
      w2 = Warehouse.create!(
        name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais')
      s = Supplier.create!(
        corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
        full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
      o = Order.create!(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
      p = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 75, depth: 80, sku: 'CGMER-XPTO-888', supplier: s)

      stock_product = StockProduct.create!(order: o, warehouse: w, product_model: p)
      original_code = stock_product.serial_number
      stock_product.update!(warehouse: w2)

      expect(stock_product.serial_number).to eq original_code
    end
  end
end
