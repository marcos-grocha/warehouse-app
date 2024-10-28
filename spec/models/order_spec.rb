require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      u = User.create!(
        name: 'Leticia', email: 'leticia@unit.com', password: '123456'
        )
      w = Warehouse.create!(
        name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais'
        )
      s = Supplier.create!(
        corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
        )
      o = Order.new(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: '2022-10-01'
        )

      result = o.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      o = Order.new(estimated_delivery_date: '')

      o.valid?

      expect(o.errors.include? :estimated_delivery_date).to be true
    end

    it 'data estimada de entrega não deve ser passada' do
      # se eu fizer vai quebrar vários testes que botei data antiga
      o = Order.new(estimated_delivery_date: '')
      o.valid?
      expect(o.errors.include? :estimated_delivery_date).to be true
    end
  end

  describe 'gera um código único e aleatório' do
    it 'ao criar um novo pedido' do
      u = User.create!(
        name: 'Leticia', email: 'leticia@unit.com', password: '123456'
        )
      w = Warehouse.create!(
        name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
        description: 'Galpão destinado para cargas internacionais'
        )
      s = Supplier.create!(
        corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
        )
      o = Order.new(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: '2022-10-01'
        )
      o2 = Order.new(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: '2022-11-15'
        )

      o.save!

      expect(o.code).not_to be_empty
      expect(o.code.length).to eq 8
      expect(o.code).not_to eq o2.code
    end

    it 'e não deve ser modificado' do
      u = User.create!(name: 'Marcos', email: 'marcos@unit.com', password: '123456')
      w = Warehouse.create!(
        name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
        address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
      s = Supplier.create!(
        corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
        full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
      o = Order.create!(
        user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
      original_code = o.code

      o.update!(estimated_delivery_date: 1.month.from_now)

      expect(o.code).to eq(original_code)
    end
  end
end
