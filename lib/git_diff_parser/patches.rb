require 'delegate'
module GitDiffParser
  # The array of patch
  class Patches < DelegateClass(Array)
    # @return [Patches<Patch>]
    def self.[](*ary)
      new(ary)
    end

    # @return [Patches<Patch>]
    def initialize(*args)
      super Array.new(*args)
    end

    # @return [Array<String>] file path
    def files
      map(&:file)
    end

    # @return [Array<String>] target sha1 hash
    def secure_hashes
      map(&:secure_hash)
    end

    # @param file [String] file path
    #
    # @return [Patch, nil]
    def find_patch_by_file(file)
      find { |patch| patch.file == file }
    end

    # @param secure_hash [String] target sha1 hash
    #
    # @return [Patch, nil]
    def find_patch_by_secure_hash(secure_hash)
      find { |patch| patch.secure_hash == secure_hash }
    end
  end
end
