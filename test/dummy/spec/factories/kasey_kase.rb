puts "LOADED KASE"

FactoryBot.define do
  factory :kase, class: Kasey::Kase do
    intake { create :intake }
  end
end
