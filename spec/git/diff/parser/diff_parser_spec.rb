require 'spec_helper'

describe Git::Diff::Parser::DiffParser do
  describe '#parse' do
    it 'returns parsed patches' do
      diff_body = File.read('spec/support/fixtures/d1bd180-c27866c.diff')
      patches = Git::Diff::Parser::DiffParser.parse(diff_body)

      expect(patches.size).to eq 4
    end
  end
end
