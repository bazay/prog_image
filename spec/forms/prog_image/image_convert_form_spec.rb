RSpec.describe ProgImage::ImageConvertForm do
  subject(:form) { described_class.new params }

  let(:params) { { 'extension' => extension, 'key' => key } }

  include_context 'with file for upload'
  include_context 'with aws s3 connector'
  include_context 'with image handler'

  describe '#valid?' do
    let(:extension) { 'PNG' }

    it { is_expected.to be_valid }

    context 'when extension is not an image extension' do
      let(:extension) { non_image_extension }

      it { is_expected.not_to be_valid }
    end

    context 'when extension is the same type as image' do
      let(:extension) { 'SVG' }

      it { is_expected.not_to be_valid }
    end
  end
end
