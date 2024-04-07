class Service < ApplicationRecord
  belongs_to :difficulty
  belongs_to :employee_profile, optional: true

  has_many :client_likes
  has_many :client_profiles, through: :client_likes
  validates :title, uniqueness: { scope: :service_type, message: 'Should be unique for each service type' }
end
