require 'git_diff_parser/version'
require 'git_diff_parser/line'
require 'git_diff_parser/patch'
require 'git_diff_parser/patches'
require 'git_diff_parser/diff_parser'

# Parser `git diff` into patches and lines
module GitDiffParser

  # @param contents [String] `git diff` result.
  #
  # @return [Patches<Patch>] parsed patches and lines
  def self.parse(contents)
    DiffParser.parse(contents)
  end
end
