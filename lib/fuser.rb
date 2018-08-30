require 'fuser/version'
require 'fuser/configuration'
require 'fuser/endpoint'
require 'fuser/request'
require 'fuser/response'

module Fuser
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.call(action, params)
    request = Fuser::Request.call(action, params: params)
    Fuser::Response.new(request.response)
  end

  I18n.t('fuser.endpoints').keys.each do |request_action|
    define_singleton_method request_action do |params|
      call(request_action, params)
    end
  end
end
