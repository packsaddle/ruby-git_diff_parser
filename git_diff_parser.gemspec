# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_diff_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_diff_parser'
  spec.version       = GitDiffParser::VERSION
  spec.authors       = ['sanemat']
  spec.email         = ['o.gata.ken@gmail.com']

  spec.summary       = 'Parser for `git diff`.'
  spec.description   = 'Parse `git diff` result.'
  spec.homepage      = 'https://github.com/packsaddle/ruby-git_diff_parser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec
    .files
    .grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 0'
  spec.add_development_dependency 'rake', '>= 0'
  spec.add_development_dependency 'rspec', '>= 0'
end
