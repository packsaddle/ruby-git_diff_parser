require 'spec_helper'

describe Git::Diff::Parser::DiffParser do
  describe '#parse' do
    let(:file1) { 'lib/saddler/reporter/github.rb' }
    let(:body1) { <<-'EOS'
@@ -2,6 +2,7 @@
 require 'octokit'
 require 'git'
 require 'saddler/reporter/github/version'
+require 'saddler/reporter/github/support'
 require 'saddler/reporter/github/helper'
 require 'saddler/reporter/github/client'
 require 'saddler/reporter/github/comment'
    EOS
    }
    let(:file2) { 'lib/saddler/reporter/github/commit_comment.rb' }
    let(:body2) { <<-'EOS'
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
    }
    it 'returns parsed patches' do
      diff_body = File.read('spec/support/fixtures/d1bd180-c27866c.diff')
      patches = Git::Diff::Parser::DiffParser.parse(diff_body)

      expect(patches.size).to eq 4
      expect(patches[0].file).to eq file1
      expect(patches[0].body).to eq body1
    end
  end
end
