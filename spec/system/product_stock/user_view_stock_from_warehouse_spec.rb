require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela de um galpão' do
    u = User.create!(name: 'Marcos', email: 'marcos@unit.com', password: '123456')
    w = Warehouse.create!(
      name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000,
      address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
    s = Supplier.create!(
      corporate_name: 'Spark Industries Brasil LTDA', brand_name: 'Spark', registration_number: '16074559000104',
      full_address: 'Torre da Indústria, 1', city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
    o = Order.create!(
      user: u, warehouse: w, supplier: s, estimated_delivery_date: 1.week.from_now, status: :delivered)
    p_cadeira = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70, width: 75, depth: 80, sku: 'CGMER-XPTO-888', supplier: s)
    p_soundbar = ProductModel.create!(name: 'Soundbar 7.1 Surround', weight: 3000, height: 70, width: 80, depth: 20, sku: 'SOU71-SAMS-888', supplier: s)
    p_notebook = ProductModel.create!(name: 'Notebook', weight: 2000, height: 90, width: 40, depth: 20, sku: 'NOTI5-SAMS-777', supplier: s)
    3.times { StockProduct.create!(order: o, warehouse: w, product_model: p_cadeira) }
    2.times { StockProduct.create!(order: o, warehouse: w, product_model: p_notebook) }

    login_as u
    visit root_path
    click_on 'Maceio'

    expect(page).to have_content 'Itens em Estoque'
    expect(page).to have_content '3 x CGMER-XPTO-888'
    expect(page).to have_content '2 x NOTI5-SAMS-777'
    within("div#estoque") do
      expect(page).not_to have_content p_soundbar.sku
    end
  end

  it 'e dá baixa em um item' do
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
    2.times { StockProduct.create!(order: o, warehouse: w, product_model: p) }

    login_as u
    visit root_path
    click_on 'Maceio'
    select 'CGMER-XPTO-888', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar Retirada'

    expect(current_path).to eq warehouse_path(w.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '1 x CGMER-XPTO-888'
  end
end
