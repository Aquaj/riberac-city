class PlaceDecorator < Draper::Decorator
  delegate_all

  def short_description
    "#{description[0...150]}..."
  end
end
