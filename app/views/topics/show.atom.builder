atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.messages_list')
  feed.updated @messages.first.updated_at if !@messages.empty?

  @messages.reverse.each do |msg|
    next if msg.updated_at.blank?

    feed.entry( msg, :id => forum_topic_url(msg.topic.forum, msg.topic, :anchor => "msg_id_#{msg.id}"), :url => forum_topic_url(msg.topic.forum, msg.topic, :anchor => "msg_id_#{msg.id}") ) do |entry|
      entry.title msg.title
      entry.content markdown(msg.content), :type => 'html'

      # the strftime is needed to work with Google Reader.
      #entry.updated(msg.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name msg.user.login
      end
    end
  end

  feed.entry( @topic, :id => forum_topic_url(@topic.forum, @topic), :url => forum_topic_url(@topic.forum, @topic) ) do |entry|
    entry.title @topic.title
    entry.content markdown(@topic.content), :type => 'html'

    # the strftime is needed to work with Google Reader.
    #entry.updated(topic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

    entry.author do |author|
      author.name @topic.user.login
    end
  end

end
