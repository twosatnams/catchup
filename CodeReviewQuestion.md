eliminate n+1 queries occuring as a result of getting number of results

I'm making a social media website which is similar to facebook and n+1 queries are slowing me down in the following situation -

Users have a friends method that looks like this -

def friends
  user_ids = Friend.where(
    '(user_id = :id OR friend_id = :id) AND pending = false',
     id: self.id
  ).pluck(:user_id, :friend_id)
   .flatten
   .uniq
   .reject { |id| id == self.id }

  User.where(id: user_ids)
end

I realize the method is not great since it executes 2 SQL queries. Any suggestions to improve that are welcome, but I want another problem solved in this question.

For my view, I want to get all the friends of a user and also the number of friends that each of the friends have. This'll enable me to implement a friend list which lists a friend, and along with it, the number of friends that friend has.

To ugly way of doing that is -

json.friends @user.friends do |friend|
  json.extract! friend, :id, :name, :profile_pic
  json.number_friends friend.friends.length
end

But obviously that's not efficient at all.

Is there a way by which I can fetch the friends of a user, and the number of friends that each of the friends have in a single query?

or is caching the number of friends of each user my only solution? 
