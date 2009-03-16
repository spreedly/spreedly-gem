require 'rake'

task :default => 'test:default'

namespace :rest_client do
  task :verbose do
    ENV["RESTCLIENT_LOG"] = "stdout"
  end
end

namespace :test do
  task :default do
    if only = ENV['TEST_ONLY']
      only = "-n /#{only}/"
    end
    ruby %(-rubygems -Ilib test/spreedly_gem_test.rb #{only})
  end
  
  task :real_on do
    ENV["SPREEDLY_TEST"] = "REAL"
  end
  
  task :real => [:real_on, :default]
  
  task :both do
    Rake::Task['test:default'].execute
    Rake::Task['test:real_on'].execute
    Rake::Task['test:default'].execute
  end
end