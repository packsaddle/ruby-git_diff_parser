module GitDiffParser
  # parsed line
  class Line
    attr_reader :number, :patch_position
    # @!attribute [r] number
    #   @return [Integer] line number
    # @!attribute [r] patch_position
    #   @return [Integer] line patch position

    # @param options [Hash] this is not options
    # @option options [Integer] :number line number (required)
    # @option options [String] :content content (required)
    # @option options [Integer] :patch_position patch position (required)
    def initialize(options = {})
      fail(ArgumentError('number is required')) unless options[:number]
      fail(ArgumentError('content is required')) unless options[:content]
      fail(ArgumentError('patch_position is required')) unless options[:patch_position]
      @number = options[:number]
      @content = options[:content]
      @patch_position = options[:patch_position]
    end

    # @return [Boolean] true if line changed
    def changed?
      true
    end
  end
end
