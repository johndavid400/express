json.extract! entry, :id, :title, :slug, :description, :data, :status, :open, :close, :user_id, :type, :created_at, :updated_at
json.url entry_url(entry, format: :json)
