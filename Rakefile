require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run all specs in spec directory'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['-cfd --backtrace']
end

task default: :spec
