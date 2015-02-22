require 'spec_helper'

describe GitDiffParser::Patch do
  describe '#changed_lines' do
    it 'returns lines that were modified' do
      patch_body = File.read('spec/support/fixtures/patch.diff')
      patch = GitDiffParser::Patch.new(patch_body)

      expect(patch.changed_lines.size).to eq(3)
      expect(patch.changed_lines.map(&:number)).to eq [14, 22, 54]
      expect(patch.changed_lines.map(&:patch_position)).to eq [5, 13, 37]
    end

    context 'when body is nil' do
      it 'returns no lines' do
        patch = GitDiffParser::Patch.new(nil)

        expect(patch.changed_lines.size).to eq(0)
      end
    end
  end
end
