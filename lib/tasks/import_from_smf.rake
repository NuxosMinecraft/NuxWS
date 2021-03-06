require "pp"
namespace :smf do
  task :import => :environment do

    ctopics = 0
    ccategories = 0
    cforums = 0
    cmessages = 0

    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "smf", :password => "")
    categories = client.query("SELECT smf_categories.id_cat as id, smf_categories.name as name, smf_categories.cat_order as position FROM smf_categories")
    categories.each do |c|
      puts "==> #{c["name"]}"
      c_nuxws = ForumCategory.find_or_create_by_name(:name => c["name"], :position => c["position"], :role => 0)
      forums = client.query("SELECT  smf_boards.id_board as id, smf_boards.name as title, smf_boards.description as description, smf_boards.board_order as position FROM smf_boards WHERE smf_boards.id_cat=#{c['id']}")
      forums.each do |f|
        puts "===> #{f["title"]}"
        f_nuxws = Forum.find_or_create_by_title(:title => f["title"], :description => f["description"], :position => f["position"], :forum_category_id => c_nuxws.id, :role => 0)
        cforums+=1
      end
      puts ""
      ccategories+=1
    end

    print "Topics & messages ~>"
    topics = client.query("select smf_boards.name as nameForum, smf_messages.poster_name as username, smf_messages.subject as title, smf_messages.body as content, smf_topics.locked as locked, smf_topics.is_sticky as pin, smf_messages.poster_time as created_at, messages2.poster_time as last_message_at, smf_topics.id_topic as id FROM smf_topics, smf_boards, smf_messages, smf_messages as messages2 WHERE smf_topics.id_board=smf_boards.id_board AND smf_topics.id_first_msg = smf_messages.id_msg AND smf_topics.id_last_msg = messages2.id_msg")
    topics.each do |t|
      forum = Forum.find_by_title(t["nameForum"])
      t_nuxws = Topic.find_or_create_by_title(:title => t["title"], :username => t["username"], :content => t["content"], :forum_id => forum.id)
      t_nuxws.created_at = Time.at(t["created_at"])
      t_nuxws.last_message_at = Time.at(t["last_message_at"])
      t_nuxws.save

      t_nuxws.pin! if t["pin"] == 1 || t["pin"] == "1"
      t_nuxws.lock! if t["lock"] == 1 || t["lock"] == "1"
      ctopics+=1

      print "T"

      messages = client.query("SELECT smf_messages.poster_name as username, smf_messages.subject as title, smf_messages.body as content, smf_messages.poster_time as created_at, smf_messages.modified_time as updated_at, smf_messages.modified_name as last_edit_by FROM smf_messages WHERE smf_messages.id_topic=#{t["id"]}")
      messages.each do |m|
        m_nuxws = Message.find_or_create_by_content(:username => m["username"], :title => m["title"], :content => m["content"], :last_edit_by => m["last_edit_by"], :topic_id => t_nuxws.id)
        m_nuxws.created_at = Time.at(m["created_at"])
        m_nuxws.updated_at = Time.at(m["updated_at"])
        m_nuxws.save
        print "."

        cmessages+=1
      end

    end
    puts ""

    print "Users ~> "
    users = client.query("SELECT smf_members.date_registered as created_at, smf_members.member_name as login, smf_members.email_address as email, smf_members.last_login as last_login_at, smf_members.member_ip as last_login_ip, smf_members.signature as signature FROM smf_members WHERE smf_members.is_activated=1 AND smf_members.id_member != 43 AND smf_members.id_member != 104 AND smf_members.id_member != 118 AND smf_members.id_member != 133 AND smf_members.id_member != 17")
    users.each do |u|
      print "."
      o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
      password = (0...50).map{ o[rand(o.length)] }.join
      u_nuxws = User.find_or_create_by_login(:login => u["login"], :signature => u["signature"], :email => u["email"], :password => password, :password_confirmation => password)
      u_nuxws.created_at = Time.at(u["created_at"])
      u_nuxws.save
      u_nuxws.associate_posts_and_topics
    end
    puts ""

    puts "Import done!"
    puts "Categories: #{ccategories}"
    puts "Forums: #{cforums}"
    puts "Topics: #{ctopics}"
    puts "Messages: #{cmessages}"

  end
end
