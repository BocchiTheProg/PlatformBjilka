class Service < ApplicationRecord
  belongs_to :difficulty
  belongs_to :employee_profile, optional: true

  has_many :client_likes
  has_many :client_profiles, through: :client_likes
  validates :title, uniqueness: { scope: :service_type, message: 'Should be unique for each service type' }

  def self.ransackable_associations(auth_object = nil)
    ["client_likes", "client_profiles", "difficulty", "employee_profile"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "difficulty_id", "employee_profile_id", "id", "id_value", "service_type", "title", "updated_at"]
  end
  
end
