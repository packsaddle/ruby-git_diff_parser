require 'delegate'
module GitDiffParser
  class Patches < DelegateClass(Array)
    def self.[](*ary)
      new(ary)
    end

    def initialize(*args)
      super Array.new(*args)
    end
  end
end
