require 'git_diff_parser.rb'
module GitDiffParser
    class CommitsByFile
        def initialize(commit_log)
            commits = GitDiffParser.parselog(commit_log)

            @commits_by_file = Hash.new {|h,k| h[k]=[]}
            @prs = []
            commits.each { |commit|
                commit.files.each { |file|
                    @commits_by_file[file] << commit
                }

                if !(commit.mhash.nil? || commit.mhash.empty?)
                  commit.comment.each { |comment|
                    if comment =~ /Merge pull request/
                      @prs << comment[/\d+/].to_i
                    end
                  }
                end
            }
        end

        def get_commits(file_name)
            return @commits_by_file[file_name]
        end

        def get_prs()
            return @prs
        end
    end
end

