require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    u = User.create!(name: 'Marcos', email: 'marcosgrocha@sim.com', password: '12345678')

    login_as(u)
    visit '/'

    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve estar autenticado' do
    visit '/'

    within('header nav') do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'e deve encontra um pedido' do
    u = User.create!(
      name: 'Marcos', email: 'marcosgrocha@ok.com', password: '12345678'
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

    login_as(u)
    visit root_path
    fill_in 'Buscar Pedido', with: o.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da Busca por: #{o.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{o.code}"
    expect(page).to have_content "Galpão Destino: #{w.code} | #{w.name}"
    expect(page).to have_content "Fornecedor: #{s.brand_name}"
  end
end
