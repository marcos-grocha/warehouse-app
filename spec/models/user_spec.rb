require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'show name plus email' do
      user = User.new(name: 'Marcos G Rocha', email: 'marcos-grocha@unit.com')

      expect(user.description).to eq 'Marcos G Rocha <marcos-grocha@unit.com>'
    end
  end
end
