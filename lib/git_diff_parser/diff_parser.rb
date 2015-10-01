module GitDiffParser
  # Parse entire `git diff` into Patches and Patch
  #
  # @deprecated
  class DiffParser
    # Parse entire `git diff` into Patches and Patch
    #
    # @deprecated Use {Patches.parse} instead.
    #
    # @param contents [String] `git diff` result
    #
    # @return [Patches<Patch>] parsed object
    def self.parse(contents)
      warn '[DEPRECATION] `DiffParser.parse` is deprecated.  Please use `Patches.parse` instead.'
      Patches.parse(contents)
    end
  end
end
