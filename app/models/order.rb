class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  enum status: { pending: 0, delivered: 3, canceled: 6 }

  validates :code, :estimated_delivery_date, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
