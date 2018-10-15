# frozen_string_literal: true

module Fuser
  module Endpoint
    def self.for(action)
      I18n.t(
        action,
        api_key: Fuser.configuration.api_key,
        scope: %i[fuser endpoints]
      )
    end
  end
end
