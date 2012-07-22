atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.messages_list')
  feed.updated @messages.first.updated_at if !@messages.empty?

  @messages.each do |msg|
    next if msg.updated_at.blank?

    feed.entry (@forum ) do |entry|
      entry.url forum_topic_url(msg.topic, msg, :anchor => "#msg_#{msg.id}")
      entry.title msg.title
      entry.content markdown(msg.content), :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(msg.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name entry.login
      end
    end
  end
end
