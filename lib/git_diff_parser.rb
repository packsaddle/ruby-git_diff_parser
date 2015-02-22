require 'git_diff_parser/version'
require 'git_diff_parser/line'
require 'git_diff_parser/patch'
require 'git_diff_parser/patches'
require 'git_diff_parser/diff_parser'

module GitDiffParser
  def self.parse(contents)
    DiffParser.parse(contents)
  end
end
