class UserSession < Authlogic::Session::Base

  validate :check_confirmed_user

  private

  def check_confirmed_user
    if !self.attempted_record.nil?
      errors.add_to_base(t(:text_your_account_is_not_confirmed)) unless self.attempted_record.confirmed?
    end
  end

end
