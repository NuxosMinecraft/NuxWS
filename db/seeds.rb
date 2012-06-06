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