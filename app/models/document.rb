class Document < ActiveRecord::Base
  DOCUMENT_TYPES = %w(Data Journal\ Article News\ Article Map Report Other)

  belongs_to :data_record

  has_attached_file :file, PAPERCLIP_CONFIG

  validate :presence_of_file_or_url
  validates_inclusion_of :document_type, :in => DOCUMENT_TYPES

  def download_url
    external_url.presence || file.url
  end

  def storage
    if @storage.present?
      @storage
    elsif external_url.present?
      "external"
    elsif file_file_name.present?
      "upload"
    end
  end

  def storage=(type)
    @storage = type
  end

  private

  def presence_of_file_or_url
    errors.add_to_base(I18n.t(:message_you_need_to_either_upload_a_file_or_provide_url)) if file_file_name.blank? && external_url.blank?
  end
end
