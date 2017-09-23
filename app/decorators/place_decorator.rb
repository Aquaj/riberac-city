class PlaceDecorator < Draper::Decorator
  delegate_all

  def short_description
    trail = '...' if description.length >= 150
    "#{description[0...150]}#{trail}"
  end
end
