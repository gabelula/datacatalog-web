class Contact < Person
  belongs_to :data_record

  validates_presence_of :name, :message => "for the contact can't be blank"
  validate :presence_of_email_or_phone

  private

  def presence_of_email_or_phone
    errors.add_to_base("Either an email or phone number is required for the contact") if email.blank? && phone.blank?
  end
end
