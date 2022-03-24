json.extract! human, :id, :name, :email, :password, :password_confirmation, :created_at, :updated_at
json.url human_url(human, format: :json)
