require 'hoe'
require './lib/spreedly/version.rb'

hoe = nil
Hoe.new('spreedly-gem', Spreedly::VERSION) do |project|
  hoe = project
  project.rubyforge_name = 'terralien'
  project.developer('Nathaniel Talbott', 'nathaniel@terralien.com')
  project.test_globs = ["test/**/*_test.rb"]
  project.extra_dev_deps = ["thoughtbot-shoulda"]
end

desc "Run tests with and without mocking."
task :test do
  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests
end

task :test_mock do
  hoe.run_tests
end

task :test_real do
  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests
end

task :multi do
  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests(true)
end