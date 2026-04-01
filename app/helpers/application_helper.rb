module ApplicationHelper
  # Returns the URL only if it uses an http/https scheme, otherwise nil.
  # Prevents XSS via javascript: or data: URIs in link_to hrefs.
  def safe_external_url(url)
    uri = URI.parse(url.to_s)
    uri.scheme.in?(%w[http https]) ? url : nil
  rescue URI::InvalidURIError
    nil
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(
      hard_wrap: true,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" }
    )
    md = Redcarpet::Markdown.new(renderer,
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      superscript: true,
      highlight: true,
      no_intra_emphasis: true
    )
    md.render(text.to_s).html_safe
  end
end
