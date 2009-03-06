require 'rake'

task :default => 'test:default'

namespace :rest_client do
  task :verbose do
    ENV["RESTCLIENT_LOG"] = "stdout"
  end
end

namespace :test do
  task :default do
    ruby %(-rubygems -Ilib test/spreedly_gem_test.rb)
  end
  
  task :real_on do
    ENV["SPREEDLY_TEST"] = "REAL"
  end
  
  task :real => [:real_on, :default]
end