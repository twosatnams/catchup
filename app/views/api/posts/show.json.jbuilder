json.extract! @post,
  :id,
  :body,
  :author_id,

json.array! @ do |user|
  json.extract! user, :id, :fname, :lname
end
