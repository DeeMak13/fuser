# frozen_string_literal: true

require 'httparty'

module Fuser
  class Request
    def self.call(*args)
      new(*args).call
    end

    def initialize(action, params: {})
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
      when :set_account_info then
        {
          'idToken': params[:token],
          'email': params[:email],
          'password': params[:password],
          'displayName': params[:display_name],
          'photoUrl': params[:photo_url],
          'deleteAttribute': params[:delete_attributes],
          'returnSecureToken': true
        }.compact
      when :get_account_info then
        {
          'idToken': params[:token]
        }
      when :oauth_sign_in then
        {
          'postBody': oauth_post_body(params),
          'requestUri': params[:request_uri],
          'returnSecureToken': true,
          'returnIdpCredential': true
        }
      when :oauth_link then
        {
          'idToken': params[:token],
          'postBody': oauth_post_body(params),
          'requestUri': params[:request_uri],
          'returnSecureToken': true,
          'returnIdpCredential': true
        }
      when :unlink_provider then
        {
          'idToken': params[:token],
          'deleteProvider': params[:providers]
        }
      when :send_email_verification then
        {
          'idToken': params[:token],
          'requestType': 'VERIFY_EMAIL'
        }
      when :confirm_email_verification then
        {
          'oobCode': params[:oob_code]
        }
      when :delete_account then
        {
          'idToken': params[:token]
        }
      end
    end

    def oauth_post_body(params)
      [
        params.slice(:access_token, :id_token)&.first&.join('='),
        params.slice(:oauth_token_secret)&.first&.join('='),
        "providerId=#{params[:provider_id]}"
      ].compact.join('&')
    end
  end
end
