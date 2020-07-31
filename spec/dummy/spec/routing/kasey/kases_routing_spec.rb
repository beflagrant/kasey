require "rails_helper"

RSpec.describe Kasey::KasesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/kasey/kases").to route_to("kasey/kases#index")
    end

    it "routes to #show" do
      expect(get: "/kasey/kases/1").to route_to("kasey/kases#show", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/kasey/kases/1").to route_to("kasey/kases#destroy", id: "1")
    end
  end
end
