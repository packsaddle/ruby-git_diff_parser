require 'git_diff_parser.rb'
module GitDiffParser
    class CommitsByFile
        def initialize(commit_log)
            commits = GitDiffParser.parselog(commit_log)

            @commits_by_file = Hash.new {|h,k| h[k]=[]}
            commits.each { |commit|
                commit.files.each { |file|
                    @commits_by_file[file] << commit
                }
            }
        end

        def get_commits(file_name)
            return @commits_by_file[file_name]
        end
    end
end

