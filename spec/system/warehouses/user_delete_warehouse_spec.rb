require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão do centro do país', address: 'Av dos Jacarés, 1000')

    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiaba'
    expect(page).not_to have_content 'CWB'
  end

  it 'e não apaga outros galpões' do
    Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão do centro do país', address: 'Av dos Jacarés, 1000')
    Warehouse.create!(name: 'b', code: 'BBB', area: 20000, cep: '16000-000', city: 'bb', description: 'Galpão do bbb', address: 'Av dos Bs, 200')

    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'BBB'
    expect(page).not_to have_content 'CWB'
  end
end
