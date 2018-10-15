# frozen_string_literal: true

require 'i18n'

I18n.available_locales = [:en]
I18n.default_locale = :en
I18n.enforce_available_locales = true
I18n.load_path += Dir.glob(File.dirname(__FILE__) + '/locales/*.{rb,yml}')
