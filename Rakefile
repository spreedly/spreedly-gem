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

def remove_task(*task_names)
  task_names.each do |task_name|
    Rake.application.instance_eval{@tasks.delete(task_name.to_s)}
  end
end
 
def replace_task(task_name, *args, &block)
  remove_task(task_name)
  task(task_name, *args, &block)
end

remove_task :docs, 'doc/index.html'
Rake::RDocTask.new(:docs) do |rd|
  rd.main = hoe.readme_file
  rd.rdoc_dir = 'doc'

  rd.rdoc_files += ['lib/spreedly.rb', 'lib/spreedly/common.rb', hoe.readme_file]

  title = "Terralien's Spreedly gem (#{hoe.version}) Documentation"

  rd.options << "-t" << title << "-f" << "darkfish"
end


desc "Run tests with and without mocking."
replace_task :test do
  hoe.run_tests

  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests
end

desc "Run only mock tests."
task :test_mock do
  hoe.run_tests
end

desc "Run only real tests."
task :test_real do
  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests
end

desc "Run both sets of tests under multiruby"
replace_task :multi do
  hoe.run_tests(true)
  ENV["SPREEDLY_TEST"] = "REAL"
  hoe.run_tests(true)
end