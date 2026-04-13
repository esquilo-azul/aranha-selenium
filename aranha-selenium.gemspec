# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'aranha/selenium/version'

Gem::Specification.new do |s|
  s.name        = 'aranha-selenium'
  s.version     = Aranha::Selenium::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Selenium\' utilities for Ruby.'

  s.files = Dir['{lib,template}/**/*', 'Gemfile']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'aranha', '~> 0.20'
  s.add_dependency 'eac_fs', '~> 0.20', '>= 0.20.1'
  s.add_dependency 'eac_ruby_utils', '~> 0.130'
  s.add_dependency 'eac_templates', '~> 0.8', '>= 0.8.3'
  s.add_dependency 'rexml', '~> 3.4', '>= 3.4.4'
  s.add_dependency 'selenium-webdriver', '~> 4.43'

  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.12', '>= 0.12.2'
  s.add_development_dependency 'stub_server', '~> 0.7'
end
