require 'delegate'
module GitDiffParser
  # The array of commit
  class Commits < DelegateClass(Array)
    # @return [Commits<Commit>]
    def self.[](*ary)
      new(ary)
    end

    # @param contents [String] `git diff` result
    #
    # @return [Commits<Commit>] parsed object
    def self.parse(contents)
      body = false
      consume = false
      author = ''
      date = ''
      chash = ''
      mhash = ''
      file = ''
      files = []
      comments = []
      commit = []
      lines = contents.lines
      line_count = lines.count
      parsed = new
      lines.each_with_index do |line, count|
        case line.chomp
        when %r{^commit (?<hash>.*)}
          if body == true
            parsed << Commit.new(hash: chash, mhash: mhash, author: author, date: date, comment: comments, files: files)
            comments.clear
            files.clear
            body = false
          end
          chash = Regexp.last_match[:hash]
          consume = true
        when %r{^Author:\s+(?<author>.*)}
          if consume 
              author = Regexp.last_match[:author]
              body = true
          end
        when %r{^Date: (?<date>.*)}
          if consume == true
              date = Regexp.last_match[:date]
              body = true
          end
        when %r{^Merge: (?<mhash>.*)}
          if consume == true
              mhash = Regexp.last_match[:mhash]
              body = true
          end
        when %r{^[ACDMRTUXB]\s(?<file>.*)}
          if consume == true
              file = Regexp.last_match[:file]
              files << file
              body = true
              if line_count == count + 1
                parsed << Commit.new(hash: chash, mergeh: mhash, author: author, date: date, comment: comments, files: files)
              end
          end
        else
          if consume == true
              comments << line
              body = true
          end
        end
      end
      parsed
    end

    # @return [Commits<Commit>]
    def initialize(*args)
      super Array.new(*args)
    end

    # @return [Array<String>] file path
    def hashes
      map(&:chash)
    end

    # @param file [String] file path
    #
    # @return [Commit, nil]
    def find_commit_by_file(file)
      find { |commit| commit.file == file }
    end

    # @param secure_hash [String] target sha1 hash
    #
    # @return [Commit, nil]
    def find_commit_by_secure_hash(secure_hash)
      find { |commit| commit.secure_hash == secure_hash }
    end
  end
end
