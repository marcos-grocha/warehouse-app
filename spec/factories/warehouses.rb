FactoryBot.define do
  factory :warehouse do
    name { "Aeroporto Maceió" }
    code { "GRU" }
    city { "Garulhos" }
    area { 100_000 }
    address { "Avenida do Aeroporto, 1000" }
    cep { "15000-000" }
    description { "Galpão destinado para cargas internacionais" }
  end
end
