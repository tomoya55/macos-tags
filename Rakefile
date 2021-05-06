require 'rake/testtask'
require 'bundler'

Bundler::GemHelper.install_tasks

task default: [:test]

Rake::TestTask.new do |test|
  # test.libs << "tests"
  # test.libs << "lib"
  test.test_files = Dir['tests/**/test_*.rb']
  test.verbose = true
end
