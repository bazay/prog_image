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
end
