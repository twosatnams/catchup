# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Friend.create({:user_id => 1, :friend_id => 2, :pending => false})
Friend.create({:user_id => 1, :friend_id => 3, :pending => false})
Friend.create({:user_id => 1, :friend_id => 4, :pending => false})
Friend.create({:user_id => 5, :friend_id => 1, :pending => false})
Friend.create({:user_id => 6, :friend_id => 1, :pending => false})
Friend.create({:user_id => 2, :friend_id => 4, :pending => false})
Friend.create({:user_id => 3, :friend_id => 5, :pending => false})
Friend.create({:user_id => 4, :friend_id => 6, :pending => false})
Friend.create({:user_id => 6, :friend_id => 3, :pending => false})
