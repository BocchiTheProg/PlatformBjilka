class ClientLike < ApplicationRecord
  belongs_to :client_profile
  belongs_to :service

  def self.ransackable_attributes(auth_object = nil)
    ["client_profile_id", "created_at", "id", "id_value", "service_id", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["client_profile", "service"]
  end
end
