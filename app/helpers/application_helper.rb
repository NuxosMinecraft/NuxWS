module ApplicationHelper
  def markdown(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(:filter_html => true, :with_toc_data => true), :autolink => true, :space_after_headers => true)
    md.render(text).html_safe
  end

  def markdown_toc(text)
    md = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC)
    md.render(text).html_safe
  end

  def ftime(time, format = "%d/%m/%Y %H:%M")
    time.strftime(format)
  end

  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
  
end
