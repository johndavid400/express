json.extract! channel, :id, :title, :slug, :description, :data, :status, :attachment_uid, :attachment_name, :attachment_size, :created_at, :updated_at
json.url channel_url(channel, format: :json)
