require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid' do
    it 'brand_name is mandatory' do
      sp = Supplier.new(brand_name: '', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'corporate_name is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: '', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'registration_number is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'full_address is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: '', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'city is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: '', state: 'SP', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'state is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: '', email: 'sac@samsung.com.br')

      expect(sp.valid?).to eq false
    end
    it 'email is mandatory' do
      sp = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number: '07317108000151', full_address: 'Av Nacoes Uniddas, 1000', city: 'São Paulo', state: 'SP', email: '')

      expect(sp.valid?).to eq false
    end
  end
end
