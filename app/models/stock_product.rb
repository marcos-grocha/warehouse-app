class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.serial_number = SecureRandom.alphanumeric(20).upcase
  end
end
