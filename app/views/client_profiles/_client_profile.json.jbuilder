json.extract! client_profile, :id, :first_name, :last_name, :phone, :user_id, :created_at, :updated_at
json.url client_profile_url(client_profile, format: :json)
