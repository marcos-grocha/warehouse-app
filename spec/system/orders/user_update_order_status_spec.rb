require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e pedido foi entregue' do
    u = User.create!(name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678')
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    p = ProductModel.create!(supplier: s, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
    o = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)
    OrderItem.create!(order: o, product_model: p, quantity: 5)

    login_as u
    visit root_path
    click_on 'Meus Pedidos'
    click_on o.code
    click_on 'Marcar como ENTREGUE'

    expect(current_path).to eq order_path(o.id)
    expect(page).to have_content 'Situação do Pedido: Entregue'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(page).not_to have_button 'Marcar como ENTREGUE'
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: p, warehouse: w).count
    expect(estoque).to eq 5
  end

  it 'e pedido foi cancelado' do
    u = User.create!(name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678')
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    p = ProductModel.create!(supplier: s, name: 'Cadeira Gamer', weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
    o = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)
    OrderItem.create!(order: o, product_model: p, quantity: 5)

    login_as u
    visit root_path
    click_on 'Meus Pedidos'
    click_on o.code
    click_on 'Marcar como CANCELADO'

    expect(current_path).to eq order_path(o.id)
    expect(page).to have_content 'Situação do Pedido: Cancelado'
    expect(page).not_to have_button 'Marcar como CANCELADO'
    expect(StockProduct.count).to eq 0
  end
end
