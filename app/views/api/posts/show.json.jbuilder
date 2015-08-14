json.extract! @post,
  :id,
  :body,
  :author_id

json.likes @post.likes do |like|
  json.extract! like, :id, :liker_id
end

json.photos @post.photos do |photo|
  json.extract! photo, :id, :url
end

# json.mentions @post.mentions do |mention|
#   json.id mention.id
#   json.mentioned_user_id mention.mentioned_user_id
#   json.extract!
# end

json.comments @post.comments do |comment|
  json.extract! comment, :id, :author_id, :body
end
