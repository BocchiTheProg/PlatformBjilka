class ClientLike < ApplicationRecord
  belongs_to :client_profile
  belongs_to :service
end
