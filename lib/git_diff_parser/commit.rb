module GitDiffParser
  # Parsed commit
  class Commit
    attr_accessor :hash, :author, :date, :comment, :files

  def debug_output
     puts '-----new Commit----'
     puts @hash
     puts @author
     puts @date
     puts @comment
     puts @files
     puts '-----end----'
  end

    def initialize( options = {})
      @hash = options[:hash].dup if options[:hash] 
      @author = options[:author].dup if options[:author] 
      @date = options[:date].dup if options[:date] 
      @comment = options[:comment].dup if options[:comment] 
      @files = options[:files].dup if options[:files] 

#     debug_output
    end
  end
end
