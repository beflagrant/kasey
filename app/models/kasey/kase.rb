require 'aasm'

class Kasey::Kase < ApplicationRecord
  include ::AASM

  aasm do
    state :open, initial: true, after_enter: :notify_us
    state :reviewed, :responded, :closed

    event :review do
      transitions from: :open, to: :reviewed
      transitions from: :reviewed, to: :reviewed
    end

    event :respond do
      transitions from: :reviewed, to: :responded
      transitions from: :responded, to: :responded
    end

    event :close do
      transitions from: :reviewed, to: :closed
      transitions from: :responded, to: :closed
    end
  end

  belongs_to :intake, polymorphic: true
  has_many :messages, -> { order  'created_at desc' }

  before_create :generate_token

  def notify_us
    Kasey::KaseMessageMailer.kase_created_email.deliver_now
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(10)
  end
end
