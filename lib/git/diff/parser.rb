require 'git/diff/parser/version'
require 'git/diff/parser/line'
require 'git/diff/parser/patch'
require 'git/diff/parser/patches'
require 'git/diff/parser/diff_parser'

module Git
  module Diff
    module Parser
      def self.parse(contents)
        DiffParser.parse(contents)
      end
    end
  end
end
