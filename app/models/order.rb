class Order < ApplicationRecord
  has_many :order_detail, dependent: :destroy
  belongs_to :customer

  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def payment_method_i18n
    I18n.t("enums.order.payment_method.#{payment_method}")
  end
  
end
