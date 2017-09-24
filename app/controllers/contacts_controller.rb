class ContactsController < ApplicationController
  def new
    @contact = Contact.new(place_id: find_place.id)
    render partial: 'form'
  end

  def create
    to_send = []
    mail = Contact.new(permitted_params)
    to_send << mail
    mail_for_sender = mail.dup.for_sender!
    to_send << mail_for_sender if mail.send_copy

    all_sent = to_send.all? do |email|
      email.request = request
      email.deliver
    end

    if all_sent
      render json: :success
    else
      render json: :failure
    end
  end

  private

  def find_place
    Place.find(params[:place_id])
  end

  def permitted_params
    params.require(:contact).permit(:place_id, :name, :email_address, :message, :send_copy)
  end
end
