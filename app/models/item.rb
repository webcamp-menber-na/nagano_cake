class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_one_attached :image
  belongs_to :admin
  
  validates :item_image, presence: true

  
  def with_tax_price
    (price * 1.1).floor
  end
  
end
