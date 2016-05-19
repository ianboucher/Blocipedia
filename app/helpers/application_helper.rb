module ApplicationHelper

  # helper method for displaying gravatar image
  def gravatar_url(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, class: "gravatar")
  end

  # helper method to display errors on forms
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end
end
