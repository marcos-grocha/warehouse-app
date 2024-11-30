require 'rails_helper'

describe 'Testando factory' do
  it 'de galpões' do
    galpao = FactoryBot.create(:warehouse)

    expect(galpao.code).to eq 'GRU'
    expect(galpao.name).to eq 'Aeroporto Maceió'
  end
end
