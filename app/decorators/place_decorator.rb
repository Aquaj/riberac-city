class PlaceDecorator < Draper::Decorator
  delegate_all

  def short_description
    trail = '...' if description.length >= 150
    "#{description[0...150]}#{trail}"
  end

  def contact_info
    emphased_number = h.tag.em(user.phone_number)
    link_to_mail = h.link_to(:contact) # TODO: Replace by actual link
    # :call_x_or.l(number: emphased_number, action: link_to_mail).html_safe
  end
end
