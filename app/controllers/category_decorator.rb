class CategoryDecorator < Draper::Decorator
  delegate_all

  def option_sentence
    options.pluck(:name).map(&:capitalize).join(',')
  end
end
