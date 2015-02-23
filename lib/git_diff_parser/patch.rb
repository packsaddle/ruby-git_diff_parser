module GitDiffParser
  class Patch
    RANGE_INFORMATION_LINE = /^@@ .+\+(?<line_number>\d+),/
    MODIFIED_LINE = /^\+(?!\+|\+)/
    NOT_REMOVED_LINE = /^[^-]/

    attr_accessor :file, :body, :hash

    def initialize(body, options = {})
      @body = body || ''
      @file = options[:file] || options['file'] if options[:file] || options['file']
      @hash = options[:hash] || options['hash'] if options[:hash] || options['hash']
    end

    def changed_lines
      line_number = 0

      lines.each_with_index.inject([]) do |lines, (content, patch_position)|
        case content
        when RANGE_INFORMATION_LINE
          line_number = Regexp.last_match[:line_number].to_i
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

    def changed_line_numbers
      changed_lines.map(&:number)
    end

    private

    def lines
      @body.lines
    end
  end
end
