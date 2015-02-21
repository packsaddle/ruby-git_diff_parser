module Git
  module Diff
    module Parser
      class DiffParser
        def self.parse(contents)
          body = false
          file_name = ''
          patch = []
          lines = contents.lines
          line_count = lines.count
          parsed = Patches.new
          lines.each_with_index do |line, count|
            case line.chomp
            when /^diff/
              unless patch.empty?
                parsed << Patch.new(patch.join("\n") + "\n", file: file_name)
                patch.clear
                file_name = ''
              end
              body = false
            when /^\-\-\-/
            when %r{^\+\+\+ b/(?<file_name>.*)}
              file_name = Regexp.last_match[:file_name]
              body = true
            when /^(?<body>[\ @\+\-\\].*)/
              patch << Regexp.last_match[:body] if body
              if !patch.empty? && body && line_count == count + 1
                parsed << Patch.new(patch.join("\n") + "\n", file: file_name)
                patch.clear
                file_name = ''
              end
            end
          end
          parsed
        end
      end
    end
  end
end
