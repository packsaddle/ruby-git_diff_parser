module GitDiffParser
  # Parsed commit
  class Commit
    attr_accessor :hash, :mhash, :author, :date, :comment, :files

  def debug_output
     puts '-----new Commit----'
     puts @hash
     puts @mhash
     puts @author
     puts @date
     puts @comment
     puts @files
     puts '-----end----'
  end

    def initialize( options = {})
      @hash = options[:hash].dup if options[:hash] 
      @mhash = options[:mhash].dup if options[:mhash] 
      @author = options[:author].dup if options[:author] 
      @date = options[:date].dup if options[:date] 
      @comment = options[:comment].dup if options[:comment] 
      @files = options[:files].dup if options[:files] 

#     debug_output
    end
  end
end
