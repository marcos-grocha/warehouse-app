require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    u = User.create!(
      name: 'User', email: 'user@admin', password: 'password'
      )
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    o = Order.create!(
      user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now
      )
    ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: s, sku: 'PRODUTO-A')
    ProductModel.create!(name: 'Produto B', weight: 16, width: 11, height: 21, depth: 31, supplier: s, sku: 'PRODUTO-B')

    login_as u
    visit root_path
    click_on 'Meus Pedidos'
    click_on o.code
    click_on 'Adicionar Item'

    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    expect(current_path).to eq order_path(o.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Produto A'
  end

  it 'e não vê produtos de outro fornecedor' do
    u = User.create!(
      name: 'User', email: 'user@admin', password: 'password'
      )
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    ss = Supplier.create!(
      corporate_name: 'RJ', brand_name: 'R', registration_number: '0', full_address: 'R J', city: 'Rio', state: 'RJ', email: 'r@j.com'
      )
    o = Order.create!(
      user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now
      )
    ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: s, sku: 'PRODUTO-A')
    ProductModel.create!(name: 'Produto B', weight: 16, width: 11, height: 21, depth: 31, supplier: ss, sku: 'PRODUTO-B')

    login_as u
    visit root_path
    click_on 'Meus Pedidos'
    click_on o.code
    click_on 'Adicionar Item'

    expect(page).to have_content 'Produto A'
    expect(page).not_to have_content 'Produto B'
  end
end
