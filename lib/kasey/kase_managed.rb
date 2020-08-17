
module Kasey
  module KaseManaged
    extend ActiveSupport::Concern

    included do
      def ensure_kase
        Kasey::Kase.find_or_create_by(intake_id: id, intake_type: self.class.to_s)
      end
    end

    module ClassMethods
      def kase_managed
        puts "MISCHIEF MANAGED"

        has_one :kase, class_name: "Kasey::Kase", as: :intake, dependent: :destroy

        after_create do
          Kasey::Kase.create(intake: self)
        end
      end
    end
  end
end

class ApplicationRecord < ActiveRecord::Base
    include Kasey::KaseManaged
      self.abstract_class = true
end
