atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.topics_list')
  feed.updated @topics.first.updated_at if !@topics.empty?

  @topics.each do |topic|
    next if topic.updated_at.blank?

    feed.entry( topic, :id => forum_topic_url(topic.forum, topic), :url => forum_topic_url(topic.forum, topic) ) do |entry|
      entry.title topic.title
      entry.content topic.content.bbcode_to_html.html_safe

      # the strftime is needed to work with Google Reader.
      #entry.updated(topic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name (topic.user ? topic.user.login : topic.username)
      end
    end
  end
end
