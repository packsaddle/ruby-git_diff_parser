# Git::Diff::Parser

[![Gem Version](http://img.shields.io/gem/v/git-diff-parser.svg?style=flat)](http://badge.fury.io/rb/git-diff-parser)
[![Build Status](http://img.shields.io/travis/packsaddle/ruby-git-diff-parser/master.svg?style=flat)](https://travis-ci.org/packsaddle/ruby-git-diff-parser)

Parser for `git diff`.

## Example

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

patches = Git::Diff::Parser.parse(diff)
=> [#<Git::Diff::Parser::Patch:0x007fb313189430
@body="@@ -2,6 +2,7 @@\n require 'octokit'\n require
 'git'\n require 'saddler/reporter/github/version'\n+r
 equire 'saddler/reporter/github/support'\n require 'sad
 dler/reporter/github/helper'\n require 'saddler/reporte
 r/github/client'\n require 'saddler/reporter/github/com
 ment'\n", @file="lib/saddler/reporter/github.rb">]

patches[0].file
=> "lib/saddler/reporter/github.rb"
patches[0].changed_lines
=> [#<Git::Diff::Parser::Line:0x007fb3130a53e8
 @number=5,
 @content="+require 'saddler/reporter/github/support'\n",
 @patch_position=4>]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/packsaddle/ruby-git-diff-parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
### git-diff-parser
Copyright (c) 2015 sanemat. [Licensed under the MIT license](./LICENSE)

### original [thoughtbot/hound](https://github.com/thoughtbot/hound)

Copyright (c) 2014 thoughtbot, inc. [Licensed under the MIT license](./thoughtbot-hound/LICENSE)

* lib/git/diff/parser/line.rb <- app/models/line.rb
* lib/git/diff/parser/patch.rb <- app/models/patch.rb
* spec/git/diff/parser/patch_spec.rb <- spec/models/patch_spec.rb
