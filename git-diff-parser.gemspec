# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/diff/parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'git-diff-parser'
  spec.version       = Git::Diff::Parser::VERSION
  spec.authors       = ['sanemat']
  spec.email         = ['o.gata.ken@gmail.com']

  spec.summary       = 'Parser for `git diff`.'
  spec.description   = 'Parse `git diff` result.'
  spec.homepage      = 'https://github.com/packsaddle/ruby-git-diff-parser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec
    .files
    .grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
