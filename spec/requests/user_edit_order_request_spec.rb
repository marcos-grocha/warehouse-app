require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    marcos = User.create!(name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678')
    leticia = User.create!(name: 'Leticia', email: 'leticia@unit.com', password: 'pass1234')
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    pedido = Order.create!(user: marcos, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)

    login_as leticia
    patch(order_path(pedido), params: { pedido: { supplier_id: 3 } })

    expect(response).to redirect_to root_path
  end
end
