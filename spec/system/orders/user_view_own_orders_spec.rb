require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê pedido dos outros' do
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
    o1 = Order.create!(user: marcos, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now, status: 'pending')
    o2 = Order.create!(user: leticia, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now, status: 'delivered')
    o3 = Order.create!(user: marcos, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: 'canceled')

    login_as(marcos)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content o1.code
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content o2.code
    expect(page).not_to have_content 'Entregue'
    expect(page).to have_content o3.code
    expect(page).to have_content 'Cancelado'
  end

  it 'e visita um pedido' do
    marcos = User.create!(name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678')
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
    pedido = Order.create!(user: marcos, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)

    login_as(marcos)
    visit root_path
    click_on 'Meus Pedidos'
    click_on pedido.code

    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content pedido.code
    expect(page).to have_content "Galpão Destino: #{w.code} | #{w.name}"
    expect(page).to have_content "Fornecedor: #{s.brand_name}"
    expect(page).to have_content "Data Prevista de Entrega: #{I18n.localize(pedido.estimated_delivery_date)}"
  end

  it 'e não visita pedidos de outros usuários' do
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

    login_as(leticia)
    visit root_path
    visit order_path(pedido.id)

    expect(current_path).not_to eq order_path(pedido.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e vê itens do pedido' do
    s = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    product_a = ProductModel.create!(name: 'Produto A', weight: 11, width: 10, height: 20, depth: 30, supplier: s, sku: 'produto-a')
    product_b = ProductModel.create!(name: 'Produto B', weight: 12, width: 10, height: 20, depth: 30, supplier: s, sku: 'produto-b')
    product_c = ProductModel.create!(name: 'Produto C', weight: 13, width: 10, height: 20, depth: 30, supplier: s, sku: 'produto-c')
    u = User.create!(name: 'User', email: 'user@email.com', password: 'password')
    w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    o = Order.create!(user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)
    OrderItem.create!(product_model: product_a, order: o, quantity: 19)
    OrderItem.create!(product_model: product_b, order: o, quantity: 12)
    OrderItem.create!(product_model: product_c, order: o, quantity: 7)

    login_as u
    visit root_path
    click_on 'Meus Pedidos'
    click_on o.code

    expect(page).to have_content 'Item de Pedido'
    expect(page).to have_content '19 x Produto A'
    expect(page).to have_content '12 x Produto B'
    expect(page).to have_content '7 x Produto C'
  end
end
