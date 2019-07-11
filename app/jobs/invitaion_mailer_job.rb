class InvitaionMailerJob < ApplicationJob
  queue_as :default

  def perform(contact,current_user)
    # Do something later
    User.invite!({email:  contact[:email]}, current_user).deliver_later
  end
end
