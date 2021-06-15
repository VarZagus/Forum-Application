json.extract! user, :id, :username, :password_digest, :is_admin, :posts_count, :created_at, :updated_at
json.url user_url(user, format: :json)
