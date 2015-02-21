require 'delegate'
module Git
  module Diff
    module Parser
      class Patches < DelegateClass(Array)
        def self.[](*ary)
          new(ary)
        end

        def initialize(*args)
          super Array.new(*args)
        end
      end
    end
  end
end
