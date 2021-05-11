require 'git_diff_parser/version'
require 'git_diff_parser/line'
require 'git_diff_parser/patch'
require 'git_diff_parser/patches'
require 'git_diff_parser/commit'
require 'git_diff_parser/commits'
require 'git_diff_parser/diff_parser'

# Parse `git diff` into patches and lines
module GitDiffParser
  # @param contents [String] `git diff` result.
  #
  # @return [Patches<Patch>] parsed patches and lines
  def self.parse(contents)
    Patches.parse(contents)
  end

  def self.parselog(contents)
    Commits.parse(contents)
  end
end
