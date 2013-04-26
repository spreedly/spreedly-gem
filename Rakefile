require "bundler/gem_tasks"

require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.libs << 'test'
# end

# desc "Run tests"
# task :default => :test



desc "Run the unit test suite"
task :default => 'test:units'

namespace :test do

  Rake::TestTask.new(:units) do |t|
    t.pattern = 'test/unit/**/*_test.rb'
    t.libs << 'test'
    t.verbose = true
  end

  Rake::TestTask.new(:remote) do |t|
    t.pattern = 'test/remote/**/*_test.rb'
    t.libs << 'test'
    t.verbose = true
  end

end

