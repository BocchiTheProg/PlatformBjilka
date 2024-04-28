class Order < ApplicationRecord
  def start_time
    date_order
  end

  belongs_to :status, optional: true
  belongs_to :client_profile
  # belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  belongs_to :employee_profile
  belongs_to :urgency
  belongs_to :service

  accepts_nested_attributes_for :comments

  def self.ransackable_associations(auth_object = nil)
    ["client_profile", "comments", "employee_profile", "service", "status", "urgency"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["client_profile_id", "created_at", "date_order", "employee_profile_id", "id", "id_value", "price", "service_id", "status_id", "updated_at", "urgency_id"]
  end
end
