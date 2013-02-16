# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Forum.create(:title => "News", :description => "Forum news")

Settings.app_title = "NuxWS"
Settings.pagination_places = 20
Settings.pagination_topics = 20
Settings.pagination_messages = 20
Settings.pagination_users = 20
Settings.pagination_galleries = 20
Settings.pagination_images = 20
Settings.pagination_docs = 20
Settings.news_forum_id = 0
Settings.presentations_forum_id = 0
Settings.rules_doc_id = 0
Settings.block_join_us = "Nous rejoindre\r\n-----------------\r\n\r\nC'est facile, suivez le guide !"