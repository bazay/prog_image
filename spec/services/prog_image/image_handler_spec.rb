RSpec.describe ProgImage::ImageHandler do
  subject(:service) { described_class.new file }

  include_context 'with file for upload'

  describe '#image_file' do
    subject { service.image_file }

    let(:file) { image_file }

    it { is_expected.to be_truthy }

    context 'when file is not an image' do
      let(:file) { text_file }

      it { is_expected.to be_nil }
    end
  end

  describe '#image?' do
    subject { service.image? }

    let(:file) { image_file }

    it { is_expected.to be_truthy }

    context 'when file is not an image' do
      let(:file) { text_file }

      it { is_expected.to be_falsey }
    end
  end

  describe '#convert_extension' do
    subject { service.convert_extension(extension) }

    let(:file) { image_file }
    let(:extension) { png_extension }
    let(:png_extension) { 'PNG' }

    it { is_expected.to be_kind_of MiniMagick::Image }
    its(:type) { is_expected.to eq png_extension }

    context 'when specified extension is not an image extension' do
      let(:extension) { 'TXT' }

      it { is_expected.to be_nil }
    end

    context 'when specified extension is the same as current image file' do
      let(:extension) { 'SVG' }

      it { is_expected.to eq image_file }
    end
  end
end
