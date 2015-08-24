json.extract! @comment, :id, :author_id, :body
json.author_name @comment.author.name
json.author_avatar @comment.author.profile_pic
json.commented_on @comment.commented_on
