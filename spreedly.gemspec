lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'spreedly/version'

Gem::Specification.new do |s|
  s.name        = "spreedly"
  s.version     = Spreedly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Spreedly"]
  s.email       = ["nathaniel@spreedly.com"]
  s.homepage    = "https://github.com/spreedly/spreedly-gem"
  s.summary     = "The Spreedly gem provides a convenient Ruby wrapper for the Spreedly Subscriptions API."

  s.required_rubygems_version = ">= 1.8"

  s.add_dependency "httparty"

  s.files        = Dir.glob("{lib}/**/*") + %w(README.md LICENSE.txt HISTORY.md)
  s.require_path = 'lib'
end
