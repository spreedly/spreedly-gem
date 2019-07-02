lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spreedly/version'

Gem::Specification.new do |s|
  s.name          = 'spreedly'
  s.version       = Spreedly::VERSION
  s.authors       = ['Spreedly']
  s.email         = ['duff@spreedly.com', 'doug@spreedly.com', 'jeremy@spreedly.com']
  s.summary       = 'Provides a Ruby wrapper for the Spreedly API.'
  s.description   = 'The Spreedly gem provides a convenient Ruby wrapper for the Spreedly API.'
  s.homepage      = 'https://github.com/spreedly/spreedly-gem'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'nokogiri'

  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'log_buddy'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'pry'
end
