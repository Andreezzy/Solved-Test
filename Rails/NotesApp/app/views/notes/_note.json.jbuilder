json.extract! note, :id, :title, :body, :flag, :category_id, :num_views, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)
