class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize[0]}"
  end
end
