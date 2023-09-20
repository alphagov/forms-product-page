class SupportForm
  include ActiveModel::Model
  include ActiveModel::Validations

  EMAIL_REGEX = /.*@.*/
  I_NEED_HELP_WITH_OPTIONS = %w[using_forms about_forms other_government_service].freeze

  attr_accessor :i_need_help_with, :message, :name, :email_address

  alias_attribute :question, :message

  validates :i_need_help_with, presence: true, inclusion: { in: I_NEED_HELP_WITH_OPTIONS }
  validates :i_need_help_with, presence: true, inclusion: { in: I_NEED_HELP_WITH_OPTIONS - %w[other_government_service] }, on: :submit
  validates :email_address, presence: true, format: { with: EMAIL_REGEX, message: :invalid_email }, on: :submit
  validates :name, presence: true, on: :submit
  validates :message, presence: true, on: :submit
  validates :question, presence: true, on: :submit

  def submit
    return false if invalid?(:submit)

    true
  end
end
