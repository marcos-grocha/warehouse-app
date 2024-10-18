require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e deve estar autenticado' do
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

    visit edit_order_path(pedido)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    marcos = User.create!(name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678')
    w = Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais'
      )
    s = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br'
      )
        Supplier.create!(
      corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
      full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
    pedido = Order.create!(user: marcos, warehouse: w, supplier: s, estimated_delivery_date: 1.day.from_now)

    login_as marcos
    visit root_path
    click_on 'Meus Pedidos'
    click_on pedido.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: '12/12/2026'
    select 'Spark Industries Brasil LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: Spark Industries Brasil LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2026'
  end

  it 'caso seja o responsável' do
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
    visit edit_order_path(pedido)

    expect(current_path).to eq root_path
  end
end
