require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run all specs in spec directory'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['-cfd --backtrace']
end

task default: :spec

require 'yard'
require 'yard/rake/yardoc_task'
DOC_FILES = ['lib/**/*.rb']
DOC_OPTIONS = ['--debug', '--verbose']
YARD::Rake::YardocTask.new(:doc) do |t|
  t.files = DOC_FILES
  t.options = DOC_OPTIONS if Rake.application.options.trace
end
