require 'hoe'
require './lib/spreedly/version.rb'

ENV["COPYFILE_DISABLE"] = "true" # Lose all the fugly ._ files when tar'ing

hoe = Hoe.spec('spreedly') do
  developer('Nathaniel Talbott', 'nathaniel@spreedly.com')
  self.test_globs = ["test/**/*_test.rb"]
  self.extra_dev_deps << ["shoulda"]
  self.extra_dev_deps << ["mechanize"]
end

def remove_task(*task_names)
  task_names.each do |task_name|
    Rake.application.instance_eval{@tasks.delete(task_name.to_s)}
  end
end
 
def replace_task(task_name, *args, &block)
  name = (task_name.is_a?(Hash) ? task_name.keys.first : task_name)
  remove_task(name)
  task(task_name, *args, &block)
end

desc "Run tests with and without mocking."
replace_task :test do
  ruby hoe.make_test_cmd

  ENV["SPREEDLY_TEST"] = "REAL"
  ruby hoe.make_test_cmd
end

desc "Run only mock tests."
task :test_mock do
  ruby hoe.make_test_cmd
end

desc "Run only real tests."
task :test_real do
  ENV["SPREEDLY_TEST"] = "REAL"
  ruby hoe.make_test_cmd
end

desc "Run both sets of tests under multiruby"
replace_task :multi do
  ruby hoe.make_test_cmd(:multi)
  ENV["SPREEDLY_TEST"] = "REAL"
  ruby hoe.make_test_cmd(:multi)
end
