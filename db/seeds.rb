# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[[1,"guest"], [4,"padawan"], [8,"player"], [12,"moderator"], [16,"admin"]].each do |role|
  Role.create(:name => role[1], :rid => role[0])
end

Forum.create(:title => "News", :description => "Forum news")

Settings.app_title = "NuxWS"
Settings.pagination_places = 20
Settings.pagination_topics = 20
Settings.pagination_messages = 20
Settings.pagination_users = 20
Settings.news_forum_id = 0
Settings.block_join_us = "Nous rejoindre\r\n-----------------\r\n\r\nC'est facile, suivez le guide !"