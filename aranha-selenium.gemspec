# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/selenium/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-selenium'
  s.version     = ::Aranha::Selenium::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Selenium\' utilities for Ruby.'

  s.files = Dir['{lib}/**/*', 'Gemfile']

  s.add_dependency 'activesupport'
  s.add_dependency 'eac_ruby_utils', '~> 0.70'
  s.add_dependency 'selenium-webdriver', '~> 3.142', '>= 3.142.3'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.3'
end
