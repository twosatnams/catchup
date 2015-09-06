json.array! @users do |user, score|
  json.extract! user, :id, :name, :profile_pic, :city
  json.dominating_criteria score.last
end
