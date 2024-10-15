class Supplier < ApplicationRecord
  has_many :product_model
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
end
