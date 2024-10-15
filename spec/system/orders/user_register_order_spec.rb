require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Leticia', email: 'leticia@unit.com', password: '123456')

    Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
      address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
    Warehouse.create!(
      name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')

    Supplier.create!(
      corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
      full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
    supplier = Supplier.create!(
      corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU | Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
    expect(page).to have_content 'Fornecedor: Samsung Eletronicos LTDA'
    expect(page).to have_content 'Usuário responsável: Leticia <leticia@unit.com>'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'Galpão Maceio'
    expect(page).not_to have_content 'Spark Industries Brasil LTDA'
  end
end
