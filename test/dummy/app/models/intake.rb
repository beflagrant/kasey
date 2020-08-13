class Intake < ApplicationRecord
  has_one :kase, class_name: "Kasey::Kase"
  has_many :assignments

  after_create :ensure_kase

  private

  def ensure_kase
    Kasey::Kase.find_or_create_by!(intake_id: id, intake_type: self.class.to_s)
  end
end
