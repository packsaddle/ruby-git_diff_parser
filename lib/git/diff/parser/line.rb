module Git
  module Diff
    module Parser
      class Line
        attr_reader :number, :patch_position

        def initialize(options = {})
          fail(ArgumentError('number is required')) unless options[:number]
          fail(ArgumentError('content is required')) unless options[:content]
          fail(ArgumentError('patch_position is required')) unless options[:patch_position]
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
