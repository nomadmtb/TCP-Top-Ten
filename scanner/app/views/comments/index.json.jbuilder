json.array!(@comments) do |comment|
  json.extract! comment, :scan_id, :user_id, :comment_date, :comment
  json.url comment_url(comment, format: :json)
end
