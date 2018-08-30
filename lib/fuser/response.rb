module Fuser
  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def body
      JSON.parse(response.body, quirks_mode: true).tap do |parsed_response|
        parsed_response.dig('error', 'message').&tap do |error_key|
          parsed_response['error']['message'] = error_explanation(error_key)
        end
      end
    end

    def raw_body
      response.body
    end

    def success?
      response.status == 200
    end

    def code
      response.status
    end

    private

    def error_explanation(error_key)
      I18n.t(
        error_key.downcase,
        scope: %i[fuser errors],
        default: default_error_message
      )
    end

    def default_error_message
      I18n.t('fuser.errors.default')
    end
  end
end
