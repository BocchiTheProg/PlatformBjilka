class Order < ApplicationRecord
  def start_time
    date_order
  end

  belongs_to :status, optional: true
  belongs_to :client_profile
  belongs_to :comment, optional: true
  belongs_to :employee_profile
  belongs_to :urgency
  belongs_to :service
end
