json.extract! user, :id, :name, :postal_code, :prefecture, :city, :address, :tel, :created_at, :updated_at
json.url user_url(user, format: :json)