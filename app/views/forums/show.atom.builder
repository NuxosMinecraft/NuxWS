atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.topics_list')
  feed.updated @topics.first.updated_at if !@topics.empty?

  @topics.each do |topic|
    next if topic.updated_at.blank?

    feed.entry( topic.forum, topic ) do |entry|
      entry.url forum_topic_url(topic.forum, topic.id)
      entry.title topic.title
      entry.content markdown(topic.content), :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(topic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name entry.login
      end
    end
  end
end
