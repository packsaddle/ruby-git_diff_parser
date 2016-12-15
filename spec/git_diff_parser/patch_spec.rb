require 'spec_helper'

module GitDiffParser
  describe Patch do
    describe '#changed_lines' do
      it 'returns lines that were modified' do
        patch_body = File.read('spec/support/fixtures/patch.diff')
        patch = Patch.new(patch_body)

        expect(patch.changed_lines.size).to eq(3)
        expect(patch.changed_lines.map(&:number)).to eq [14, 22, 54]
        expect(patch.changed_lines.map(&:patch_position)).to eq [5, 13, 37]
      end

      context 'when body is nil' do
        it 'returns no lines' do
          patch = Patch.new(nil)

          expect(patch.changed_lines.size).to eq(0)
        end
      end
    end

    describe '#changed_line_numbers' do
      it 'returns line numbers that were modified' do
        patch_body = File.read('spec/support/fixtures/patch.diff')
        patch = Patch.new(patch_body)

        expect(patch.changed_line_numbers.size).to eq(3)
        expect(patch.changed_line_numbers).to eq [14, 22, 54]
      end

      context 'when body is nil' do
        it 'returns no line numbers' do
          patch = Patch.new(nil)

          expect(patch.changed_line_numbers.size).to eq(0)
        end
      end
    end

    context "Newline inserted at EOF" do
      describe "changed_line_numbers" do
        it "returns changed line number" do
          patch_body = File.read('spec/support/fixtures/file4.diff')
          patch = Patch.new(patch_body)

          expect(patch.changed_line_numbers).to eq [4]
        end
      end
    end

    describe '#find_patch_position_by_line_number' do
      it 'returns patch position that were included' do
        patch_body = File.read('spec/support/fixtures/patch.diff')
        patch = Patch.new(patch_body)
        position = 5

        expect(patch.find_patch_position_by_line_number(12)).to be_nil
        expect(patch.find_patch_position_by_line_number(14)).to eq(position)
      end

      context 'when body is nil' do
        it 'returns no patch position' do
          patch = Patch.new(nil)

          expect(patch.find_patch_position_by_line_number(14)).to be_nil
        end
      end
    end
  end
end
