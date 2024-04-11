json.extract! post_target, :id, :api, :key, :headers, :field_mapping, :success_code, :created_at, :updated_at
json.url post_target_url(post_target, format: :json)
