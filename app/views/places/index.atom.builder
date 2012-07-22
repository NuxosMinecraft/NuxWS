atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.places_list')
  feed.updated @places.first.updated_at if !@places.empty?

  @places.each do |place|
    next if place.updated_at.blank?

    feed.entry( place ) do |entry|
      entry.title place.short_description
      entry.content markdown(place.description), :type => 'html'

      # the strftime is needed to work with Google Reader.
      #entry.updated(topic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

      entry.author do |author|
        author.name place.user.login
      end
    end
  end
end
