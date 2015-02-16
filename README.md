# Git::Diff::Parser

[![Gem Version](http://img.shields.io/gem/v/git-diff-parser.svg?style=flat)](http://badge.fury.io/rb/git-diff-parser)
[![Build Status](http://img.shields.io/travis/packsaddle/ruby-git-diff-parser/master.svg?style=flat)](https://travis-ci.org/packsaddle/ruby-git-diff-parser)

Parser for `git diff`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/git-diff-parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
### git-diff-parser
Copyright (c) 2015 sanemat. [Licensed under the MIT license](./LICENSE)

### original [thoughtbot/hound](https://github.com/thoughtbot/hound)

Copyright (c) 2014 thoughtbot, inc. [Licensed under the MIT license](./thoughtbot-hound/LICENSE)

* app/models/line.rb -> lib/git/diff/parser/line.rb
* app/models/patch.rb -> lib/git/diff/parser/patch.rb
* spec/models/patch_spec.rb -> spec/git/diff/parser/patch_spec.rb
