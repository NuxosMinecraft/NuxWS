atom_feed :language => Settings.app_lang do |feed|
  feed.title t('.documents_list')
  feed.updated @docs.first.updated_at if !@docs.empty?

  @docs.each do |doc|
    next if doc.updated_at.blank?

    feed.entry( doc ) do |entry|
      entry.title doc.title
      entry.content markdown(doc.content), :type => 'html'

      # the strftime is needed to work with Google Reader.
      #entry.updated(topic.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

    end
  end
end
