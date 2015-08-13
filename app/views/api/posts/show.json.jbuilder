json.extract! @post,
  :id,
  :body,
  :author_id


json.likes @post.likes do |like|
  json.id like.id
  json.liker_id like.liker_id
end

json.photos @post.photos do |photo|
  json.id photo.id
  json.url photo.url
end

json.mentions @post.mentions do |mention|
  json.id mention.id
  json.mentioned_user_id mention.mentioned_user_id
end

json.comments @post.comments do |comment|
  json.id comment.id
  json.author_id comment.author_id
  json.body comment.body
end
