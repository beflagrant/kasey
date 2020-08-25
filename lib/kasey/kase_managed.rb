
module Kasey
  module KaseManaged
    extend ActiveSupport::Concern

    module ClassMethods
      def kase_managed
        has_one :kase, class_name: "Kasey::Kase", as: :intake, dependent: :destroy

        after_create do
          Kasey::Kase.find_or_create_by(intake_id: id, intake_type: self.class.to_s)
        end
      end
    end
  end
end

class ApplicationRecord < ActiveRecord::Base
    include Kasey::KaseManaged
      self.abstract_class = true
end
