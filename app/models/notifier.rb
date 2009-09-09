class Notifier < ActionMailer::Base
  
  def confirmation_instructions(user)
    subject       "Please confirm your account"
    from          "National Data Catalog <support@nationaldatacatalog.com>"
    recipients    user.email
    sent_on       Time.now
    body          :confirmation_url => confirm_url(user.perishable_token)
  end

  def welcome_message(user)
    subject       "Thanks for confirming!"
    from          "National Data Catalog <support@nationaldatacatalog.com>"
    recipients    user.email
    sent_on       Time.now
    body          :profile_url => profile_url
  end

end