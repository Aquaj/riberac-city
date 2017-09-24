class Contact < MailForm::Base
  MAIL_REGEXP = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute     :place_id, validate: true
  attribute     :name, validate: true
  attribute     :email_address, validate: MAIL_REGEXP
  attribute     :message, validate: true

  attr_accessor :dest
  attr_accessor :send_copy

  def place
    Place.find(place_id)
  end

  def headers
    {
      subject: "Ribérent - Un nouveau message pour #{place.title}",
      to: destination,
      from: %("#{name} via Ribérent" <#{email_address}>)
    }
  end

  def destination
    self.dest || place.user.email
  end

  def for_sender!
    self.dest = self.email_address
    self
  end
end
