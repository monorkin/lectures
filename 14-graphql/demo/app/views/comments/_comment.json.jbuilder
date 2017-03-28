json.extract! comment, :id, :body, :author_id, :post_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)