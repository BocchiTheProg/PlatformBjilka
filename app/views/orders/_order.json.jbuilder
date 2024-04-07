json.extract! order, :id, :status_id, :client_profile_id, :comment_id, :employee_id, :urgency_id, :date_order, :service_id, :price, :created_at, :updated_at
json.url order_url(order, format: :json)
