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

    def secure_hashes
      map(&:secure_hash)
    end

    def find_patch_by_file(file)
      find { |patch| patch.file == file }
    end

    def find_patch_by_secure_hash(secure_hash)
      find { |patch| patch.secure_hash == secure_hash }
    end
  end
end
