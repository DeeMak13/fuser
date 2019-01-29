# frozen_string_literal: true

require 'httparty'

module Fuser
  class Request
    def self.call(*args)
      new(*args).call
    end

    def initialize(action, params:)
      @action = action
      @params = params
    end

    def call
      HTTParty.post(
        Fuser::Endpoint.for(action),
        body: request_body.to_json,
        headers: default_request_headers
      )
    end

    private

    attr_accessor :action, :params

    def default_request_headers
      { 'Content-Type': 'application/json' }
    end

    def request_body
      case action
      when :verify_token then
        {
          'idToken': params[:token],
          'returnSecureToken': true
        }
      when :refresh_token then
        {
          'grant_type': 'refresh_token',
          'refresh_token': params[:token]
        }
      when :sign_in, :sign_up then
        {
          'email': params[:email],
          'password': params[:password],
          'returnSecureToken': true
        }
      when :anonymous_sign_in then
        {
          'returnSecureToken': true
        }
      when :reset_password then
        {
          'email': params[:email],
          'requestType': 'PASSWORD_RESET'
        }
      when :verify_reset_password then
        {
          'oobCode': params[:oob_code]
        }
      when :confirm_reset_password then
        {
          'oobCode': params[:oob_code],
          'newPassword': params[:new_password]
        }
      when :change_email then
        {
          'idToken': params[:token],
          'email': params[:email],
          'returnSecureToken': true
        }
      when :change_password then
        {
          'idToken': params[:token],
          'password': params[:password],
          'returnSecureToken': true
        }
      when :set_account_info then
        {
          'idToken': params[:token],
          'email': params[:email],
          'password': params[:password],
          'returnSecureToken': true
        }.compact
      end
    end
  end
end
