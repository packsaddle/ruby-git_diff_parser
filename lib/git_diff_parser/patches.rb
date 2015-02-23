require 'delegate'
module GitDiffParser
  class Patches < DelegateClass(Array)
    def self.[](*ary)
      new(ary)
    end

    def initialize(*args)
      super Array.new(*args)
    end

    def files
      map(&:file)
    end

    def hashes
      map(&:hash)
    end

    def find_patch_by_file(file)
      find { |patch| patch.file == file }
    end

    def find_patch_by_hash(hash)
      find { |patch| patch.hash == hash }
    end
  end
end
