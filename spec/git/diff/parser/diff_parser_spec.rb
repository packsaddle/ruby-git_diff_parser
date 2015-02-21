require 'spec_helper'

describe Git::Diff::Parser::DiffParser do
  describe '#parse' do
    let(:file1) { 'lib/saddler/reporter/github.rb' }
    let(:body1) do
      <<-'EOS'
@@ -2,6 +2,7 @@
 require 'octokit'
 require 'git'
 require 'saddler/reporter/github/version'
+require 'saddler/reporter/github/support'
 require 'saddler/reporter/github/helper'
 require 'saddler/reporter/github/client'
 require 'saddler/reporter/github/comment'
    EOS
    end
    let(:file2) { 'lib/saddler/reporter/github/commit_comment.rb' }
    let(:body2) do
      <<-'EOS'
@@ -2,6 +2,7 @@ module Saddler
   module Reporter
     module Github
       class CommitComment
+        include Support
         include Helper

         # https://developer.github.com/v3/repos/comments/#create-a-commit-comment
@@ -11,7 +12,7 @@ def report(messages, options)
           data = parse(messages)

           # build comment
-          body = build_body(data)
+          body = concat_body(data)
           return if body.empty?
           comment = Comment.new(sha1, body, nil, nil)

@@ -25,20 +26,6 @@ def report(messages, options)
           # create commit_comment
           client.create_commit_comment(comment)
         end
-
-        def build_body(data)
-          buffer = []
-          files = data['checkstyle']['file'] ||= []
-          files.each do |file|
-            errors = file['error'] ||= []
-            errors.each do |error|
-              severity = error['@severity'] && error['@severity'].upcase
-              message = error['@message']
-              buffer << [severity, message].compact.join(': ')
-            end
-          end
-          buffer.join("\n")
-        end
       end
     end
   end
    EOS
    end
    let(:file3) { 'lib/saddler/reporter/github/helper.rb' }
    let(:body3) do
      <<-'EOS'
@@ -2,40 +2,21 @@ module Saddler
   module Reporter
     module Github
       module Helper
-        def initialize(output)
-          @output = output
-        end
-
-        def report(messages, _options)
-          @output.puts messages
-        end
-
-        # {"checkstyle"=>
-        #    {"file"=>
-        #       [{"error"=>
-        #           [{"@column"=>"4",
-        #             "@line"=>"22",
-        #             "@message"=>"Assignment Branch Condition size for report is too high. [34.34/15]",
-        #             "@severity"=>"info",
-        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/AbcSize"},
-        #            {"@column"=>"4",
-        #             "@line"=>"22",
-        #             "@message"=>"Cyclomatic complexity for report is too high. [10/6]",
-        #             "@severity"=>"info",
-        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/CyclomaticComplexity"},
-        #            {"@column"=>"6",
-        #             "@line"=>"39",
-        #             "@message"=>"Use space after control keywords.",
-        #             "@severity"=>"info",
-        #             "@source"=>"com.puppycrawl.tools.checkstyle.Style/SpaceAfterControlKeyword"}],
-        #         "@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/cli.rb"},
-        #        {"@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/reporter.rb"}]}}
-        def parse(xml)
-          Nori
-            .new(parser: :rexml)
-            .parse(xml)
+        def concat_body(data)
+          buffer = []
+          files = data['checkstyle']['file'] ||= []
+          files.each do |file|
+            errors = file['error'] ||= []
+            errors.each do |error|
+              severity = error['@severity'] && error['@severity'].upcase
+              message = error['@message']
+              buffer << [severity, message].compact.join(': ')
+            end
+          end
+          buffer.join("\n")
         end
       end
     end
   end
 end
+
      EOS
    end
    it 'returns parsed patches' do
      diff_body = File.read('spec/support/fixtures/d1bd180-c27866c.diff')
      patches = Git::Diff::Parser::DiffParser.parse(diff_body)

      expect(patches.size).to eq 4
      expect(patches[0].file).to eq file1
      expect(patches[0].body).to eq body1
      expect(patches[1].file).to eq file2
      expect(patches[1].body).to eq body2
      expect(patches[2].file).to eq file3
      expect(patches[2].body).to eq body3
    end
  end
end
