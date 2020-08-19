require "webpacker/helper"

module Kasey
  module ApplicationHelper
    include ::Webpacker::Helper

    def current_webpacker_instance
      Kasey.webpacker
    end
  end
end
