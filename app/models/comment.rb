class Comment < ApplicationRecord
  # has_one :order, dependent: :destroy, inverse_of: :comment
  belongs_to :order
  accepts_nested_attributes_for :order

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "id_value", "order_id", "updated_at"]
  end
end
