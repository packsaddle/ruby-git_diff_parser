module GitDiffParser
  # Parsed patch
  class Patch
    RANGE_INFORMATION_LINE = /^@@ .+\+(?<line_number>\d+),/
    MODIFIED_LINE = /^\+(?!\+|\+)/
    NOT_REMOVED_LINE = /^[^-]/
    NO_NEWLINE_MESSAGE = /^\\ No newline at end of file$/

    attr_accessor :file, :body, :secure_hash
    # @!attribute [rw] file
    #   @return [String, nil] file path or nil
    # @!attribute [rw] body
    #   @return [String, nil] patch section in `git diff` or nil
    #   @see #initialize
    # @!attribute [rw] secure_hash
    #   @return [String, nil] target sha1 hash or nil

    # @param body [String] patch section in `git diff`.
    #   GitHub's pull request file's patch.
    #   GitHub's commit file's patch.
    #
    #    <<-BODY
    #    @@ -11,7 +11,7 @@ def valid?
    #
    #       def run
    #         api.create_pending_status(*api_params, 'Hound is working...')
    #    -    @style_guide.check(pull_request_additions)
    #    +    @style_guide.check(api.pull_request_files(@pull_request))
    #         build = repo.builds.create!(violations: @style_guide.violations)
    #         update_api_status(build)
    #       end
    #    @@ -19,6 +19,7 @@ def run
    #       private
    #
    #       def update_api_status(build = nil)
    #    +    # might not need this after using Rubocop and fetching individual files.
    #         sleep 1
    #         if @style_guide.violations.any?
    #           api.create_failure_status(*api_params, 'Hound does not approve', build_url(build))
    #    BODY
    #
    # @param options [Hash] options
    # @option options [String] :file file path
    # @option options [String] 'file' file path
    # @option options [String] :secure_hash target sha1 hash
    # @option options [String] 'secure_hash' target sha1 hash
    #
    # @see https://developer.github.com/v3/repos/commits/#get-a-single-commit
    # @see https://developer.github.com/v3/pulls/#list-pull-requests-files
    def initialize(body, options = {})
      @body = body || ''
      @file = options[:file] || options['file'] if options[:file] || options['file']
      @secure_hash = options[:secure_hash] || options['secure_hash'] if options[:secure_hash] || options['secure_hash']
    end

    # @return [Array<Line>] changed lines
    def changed_lines
      line_number = 0

      lines.each_with_index.inject([]) do |lines, (content, patch_position)|
        case content
        when RANGE_INFORMATION_LINE
          line_number = Regexp.last_match[:line_number].to_i
        when NO_NEWLINE_MESSAGE
          # nop
        when MODIFIED_LINE
          line = Line.new(
            content: content,
            number: line_number,
            patch_position: patch_position
          )
          lines << line
          line_number += 1
        when NOT_REMOVED_LINE
          line_number += 1
        end

        lines
      end
    end

    # @return [Array<Integer>] changed line numbers
    def changed_line_numbers
      changed_lines.map(&:number)
    end

    # @param line_number [Integer] line number
    #
    # @return [Integer, nil] patch position
    def find_patch_position_by_line_number(line_number)
      target = changed_lines.find { |line| line.number == line_number }
      return nil unless target
      target.patch_position
    end

    private

    def lines
      @body.lines
    end
  end
end
