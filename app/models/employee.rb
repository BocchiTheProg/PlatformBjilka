class Employee < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@karazin\.ua\z/i, message: 'must have domain karazin.ua' }

  has_one :employee_profile, dependent: :destroy, inverse_of: :employee
  accepts_nested_attributes_for :employee_profile

  def with_employee_profile
    build_employee_profile if employee_profile.nil?
    self
  end

  def self.ransackable_associations(auth_object = nil)
    ["employee_profile"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
