require 'rails_helper'

describe 'Usuário visita tela incial' do
  it 'e vê o nome da app' do
    # Arrange
    # Act
    visit(root_path)
    # Assert
    expect(page).to have_content('Galpões & Estoque')
    expect(page).to have_link('Galpões & Estoque', href: root_path)
  end

  it 'e vê galpões cadastrados' do
    # Arrange
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av Atlantica, 50', cep: '80000-000', description: 'Perto do Aeroporto')
    # Act
    visit(root_path)
    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados!')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m2')
  end

  it 'e não tem nenhum galpão cadastrado' do
    visit(root_path)

    expect(page).to have_content('Não existem galpões cadastrados!')
  end
end
