module WikisHelper

  def markdown(text)
    options = {
      filter_html:         true,
      hard_wrap:           true,
      space_after_headers: true,
      fenced_code_blocks:  true,
      escape_html:         true,
      prettify:            true,
      link_attributes:     { rel: 'nofollow', target: "_blank_" }
    }
    extensions = {
      autolink:            true,
      superscript:         true,
      no_intra_emphasis:   true,
      # disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
