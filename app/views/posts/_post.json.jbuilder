json.extract! post, :id, :title, :content, :from, :crawler_record_id, :created_at, :updated_at
json.url post_url(post, format: :json)
