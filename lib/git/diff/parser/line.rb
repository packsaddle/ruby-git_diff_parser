module Git
  module Diff
    module Parser
      class Line
        attr_reader :number, :patch_position

        def initialize(options = {})
          if !options[:number] || !options[:content] || !options[:patch_position]
            fail(ArgumentError('this param is required'))
          end
          @number = options[:number]
          @content = options[:content]
          @patch_position = options[:patch_position]
        end

        def changed?
          true
        end
      end
    end
  end
end
