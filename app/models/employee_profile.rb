class EmployeeProfile < ApplicationRecord
  belongs_to :employee, dependent: :destroy
  belongs_to :specialization
  has_many :services, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
  validates :date_registration, presence: true
  validates :specialization, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["employee", "orders", "services", "specialization"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date_registration", "employee_id", "first_name", "id", "id_value", "last_name", "phone", "specialization_id", "updated_at"]
  end
end

