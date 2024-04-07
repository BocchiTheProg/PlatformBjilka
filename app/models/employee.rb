class Employee < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@karazin\.ua\z/i, message: 'must have domain karazin.ua' }

  has_one :employee_profile, dependent: :destroy, inverse_of: :employee
  accepts_nested_attributes_for :employee_profile

  def with_employee_profile
    build_employee_profile if employee_profile.nil?
    self
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
