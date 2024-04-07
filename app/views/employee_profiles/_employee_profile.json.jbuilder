json.extract! employee_profile, :id, :first_name, :last_name, :phone, :date_registration, :user_id, :specialization_id, :created_at, :updated_at
json.url employee_profile_url(employee_profile, format: :json)
