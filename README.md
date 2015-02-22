# GitDiffParser

[![Gem Version](http://img.shields.io/gem/v/git_diff_parser.svg?style=flat)](http://badge.fury.io/rb/git_diff_parser)
[![Build Status](http://img.shields.io/travis/packsaddle/ruby-git_diff_parser/master.svg?style=flat)](https://travis-ci.org/packsaddle/ruby-git_diff_parser)

Parser for `git diff`.

## Examples

```ruby
diff = <<'EOL'
diff --git a/lib/saddler/reporter/github.rb b/lib/saddler/reporter/github.rb
index fc33cdd..0638356 100644
--- a/lib/saddler/reporter/github.rb
+++ b/lib/saddler/reporter/github.rb
@@ -2,6 +2,7 @@
 require 'octokit'
 require 'git'
 require 'saddler/reporter/github/version'
+require 'saddler/reporter/github/support'
 require 'saddler/reporter/github/helper'
 require 'saddler/reporter/github/client'
 require 'saddler/reporter/github/comment'
EOL

patches = GitDiffParser.parse(diff)
#=> [#<GitDiffParser::Patch:0x007fb313189430
# @body="@@ -2,6 +2,7 @@\n require 'octokit'\n require
# 'git'\n require 'saddler/reporter/github/version'\n+r
# equire 'saddler/reporter/github/support'\n require 'sad
# dler/reporter/github/helper'\n require 'saddler/reporte
# r/github/client'\n require 'saddler/reporter/github/com
# ment'\n", @file="lib/saddler/reporter/github.rb">]

patches[0].file
#=> "lib/saddler/reporter/github.rb"

patches[0].changed_lines
#=> [#<GitDiffParser::Line:0x007fb3130a53e8
# @number=5,
# @content="+require 'saddler/reporter/github/support'\n",
# @patch_position=4>]
```

```ruby
diff = <<-'EOS'
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

patch = GitDiffParser::Patch.new(diff)
#=> #<GitDiffParser::Patch:0x007fb068ca7a18
# @body="@@ -2,6 +2,7 @@ module Saddler (snip)">

patch.changed_lines
#=> [#<GitDiffParser::Line:0x007fb068c17af8 @number=5,
# @content="+        include Support\n", @patch_position=4>,
# <GitDiffParser::Line:0x007fb068c17580 @number=15,
# @content="+          body = concat_body(data)\n", @patch_position=13>]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_diff_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git_diff_parser

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/packsaddle/ruby-git_diff_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
### git_diff_parser
Copyright (c) 2015 sanemat. [Licensed under the MIT license](./LICENSE)

### original [thoughtbot/hound](https://github.com/thoughtbot/hound)

Copyright (c) 2014 thoughtbot, inc. [Licensed under the MIT license](./thoughtbot-hound/LICENSE)

* lib/git_diff_parser/line.rb <- app/models/line.rb
* lib/git_diff_parser/patch.rb <- app/models/patch.rb
* spec/git_diff_parser/patch_spec.rb <- spec/models/patch_spec.rb
