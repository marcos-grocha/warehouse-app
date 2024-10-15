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
  end
end
