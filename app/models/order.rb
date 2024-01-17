class Order < ApplicationRecord
  has_many :order_detail, dependent: :destroy
  belongs_to :customer
  
  validates :postage, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }

end
