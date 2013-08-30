class Mailer < ActionMailer::Base
  default from: "from@oncahoots.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  #def invitation
  #  @greeting = "Hi"
  #
  #  mail to: "to@example.org"
  #end

  def invitation(invitation, signup_url)
    subject    'Invitation'
    recipients invitation.recipient_email
    body       :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end
end
