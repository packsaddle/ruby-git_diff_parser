require 'delegate'
module Git
  module Diff
    module Parser
      class Patches < DelegateClass(Set)
        def self.[](*ary)
          new(ary)
        end

        def initialize(*args)
          super Set.new(*args)
        end
      end
    end
  end
end
