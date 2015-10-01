'use strict';
var execSync = require('child_process').execSync;
var URI = require('urijs');

var gemspec = JSON.parse(execSync('bundle exec parse-gemspec-cli git_diff_parser.gemspec'));
var homepageUrl = gemspec.homepage;
var url = new URI(homepageUrl);
var host = url.protocol() + '://' + url.authority();
var owner = url.pathname().split('/')[1];
var repository = url.pathname().split('/')[2];

module.exports = {
  version: gemspec.version,
  host: host,
  owner: owner,
  repository: repository
};
