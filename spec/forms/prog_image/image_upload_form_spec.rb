RSpec.describe ProgImage::ImageUploadForm do
  subject(:form) { described_class.new params }

  let(:params) { uploaded_image_file }

  include_context 'with file for upload'

  describe '#valid?' do
    it { is_expected.to be_valid }

    describe 'invalid files for upload' do
      before { form.valid? }

      context 'with invalid filename' do
        let(:params) { uploaded_image_file.merge('filename' => nil) }

        its(:errors) { is_expected.to be_added(:filename) }
      end

      context 'when file provided is not an image' do
        let(:params) { uploaded_text_file }

        its(:errors) { is_expected.to be_added(:base) }
      end
    end
  end
end
