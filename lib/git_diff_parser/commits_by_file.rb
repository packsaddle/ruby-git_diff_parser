require 'git_diff_parser.rb'
module GitDiffParser
    class CommitsByFile
        def initialize(commit_log)
            commits = GitDiffParser.parselog(commit_log)
            @merge_commits = {}
            commits.each { |commit|
              if !commit.mhash.nil?
                orig_hash = commit.mhash.split(" ").last
                @merge_commits[orig_hash] = commit
              end
            }

            @commits_by_file = Hash.new {|h,k| h[k]=[]}
            @prs = []
            commits.each { |commit|
                commit.files.each { |file|
                    short_chash = commit.hash[0...7]
                    if !@merge_commits[short_chash].nil?
                      c = @merge_commits[short_chash]
                      #c.comment << commit.comment 
                      @commits_by_file[file] << c
                    else
                      @commits_by_file[file] << commit
                    end
                }

                if !(commit.mhash.nil? || commit.mhash.empty?)
                  commit.comment.each { |comment|
                    if comment =~ /Merge pull request/
                      id = comment[/\d+/].to_i
                      text = comment.split(" from ").last
                      @prs << {:id => id, :text => text, :author => commit.author}
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

