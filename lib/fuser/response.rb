# frozen_string_literal: true

require 'json'

module Fuser
  class Response
    def initialize(response, action:)
      @response = response
      @action = action
    end

    def body
      @body ||= JSON.parse(response.body, quirks_mode: true).tap do |parsed_response|
        expand_error(parsed_response)
      end
    end

    def raw_body
      response.body
    end

    def success?
      code == '200'
    end

    def code
      response.code
    end

    def error_message
      body.dig('error', 'message')
    end

    private

    attr_accessor :response, :action

    def error_explanation(error_key)
      I18n.t(
        error_key.downcase,
        scope: [:fuser, :errors, action],
        default: default_error_message
      )
    end

    def default_error_message
      I18n.t('fuser.errors.default')
    end

    def expand_error(parsed_response)
      error_key = parsed_response.dig('error', 'message')
      return unless error_key

      parsed_response.deep_merge!(
        'error' => {
          'message' => error_explanation(error_key),
          'key' => error_key
        }
      )
    end
  end
end
