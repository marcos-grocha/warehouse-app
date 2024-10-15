require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    fill_in 'Razão Social', with: 'Samsung Eletronicos LTDA'
    fill_in 'Nome Fantasia', with: 'Samsung'
    fill_in 'CNPJ', with: '07317108000151'
    fill_in 'Endereço', with: 'Av Nacoes Uniddas, 1000'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'sac@samsung.com.br'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Deu certo caraiiii'
    expect(page).to have_content 'Samsung Eletronicos LTDA'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content '07317108000151'
    expect(page).to have_content 'Av Nacoes Uniddas, 1000'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'SP'
    expect(page).to have_content 'sac@samsung.com.br'
  end

  it 'e não preenche todos os campos' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'não deu certo brother'
  end
end
