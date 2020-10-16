module Kasey
  class Message < ApplicationRecord
    enum direction: %i[internal in out]
    has_rich_text :body
    has_many_attached :files
    belongs_to :kase

    def sender
      return 'internal note' if internal?
      return self.kase.intake.email if in?
      return self.sent_by if out?
    end

    private

    def editable?
      internal?
    end
  end
end
