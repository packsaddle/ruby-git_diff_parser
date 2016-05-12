module GitDiffParser
  # Parsed line
  class Line
    attr_reader :content, :number, :patch_position
    # @!attribute [r] content
    #   @return [String] content
    # @!attribute [r] number
    #   @return [Integer] line number
    # @!attribute [r] patch_position
    #   @return [Integer] line patch position

    # @param params [Hash] required params
    # @option params [Integer] :number line number (required)
    # @option params [String] :content content (required)
    # @option params [Integer] :patch_position patch position (required)
    def initialize(params)
      raise(ArgumentError('number is required')) unless params[:number]
      raise(ArgumentError('content is required')) unless params[:content]
      raise(ArgumentError('patch_position is required')) unless params[:patch_position]
      @number = params[:number]
      @content = params[:content]
      @patch_position = params[:patch_position]
    end

    # @return [Boolean] true if line changed
    def changed?
      true
    end
  end
end
